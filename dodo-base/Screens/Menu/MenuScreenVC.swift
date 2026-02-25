//
//  ViewController.swift
//  UIKitHomework
//
//  Created by Andrew on 20.07.2025.
//

import UIKit
import SnapKit

private enum MenuSection: Int, CaseIterable {
    case stories
    case banners
    case products
}

final class MenuScreenVC: UIViewController {
    
    private let viewModel: MenuViewModelInput
    
    private let productStorage = ProductsStorage()
    private let priceButton = PriceButton(price: "270 \u{20BD}")
    private let addressButton = AddressButton()
    private let errorMenuStateView = ErrorMenuStateView()
    private let shimmerMenuView = ShimmerMenuView()
    private let totalPriceCounter = TotalPriceCounter()
    private let productsStorage: IProductsStorage
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.registerCell(ProductCell.self)
        tableView.registerCell(PromoProductCell.self)
        tableView.registerCell(BannerCell.self)
        tableView.registerHeader(CategoryContainerHeader.self)
        tableView.registerCell(StoryCell.self)
        return tableView
    }()
    
    init(viewModel: MenuViewModelInput, productsStorage: IProductsStorage) {
        self.viewModel = viewModel
        self.productsStorage = productsStorage
        super.init(nibName: nil, bundle: nil)

        (viewModel as? MenuViewModel)?.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupObservers()
        viewModel.onViewDidLoad()
        updatePriceButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .basketUpdated, object: nil)
    }
}

//MARK: - View State
extension MenuScreenVC: MenuViewModelOutput {

    func render(state: MenuScreenState) {
        switch state {
        case .initial, .loading:
            shimmerMenuView.isHidden = false
            shimmerMenuView.start()
            tableView.isHidden = true
            errorMenuStateView.isHidden = true
            priceButton.isHidden = true
            addressButton.isHidden = true

        case .loaded:
            shimmerMenuView.isHidden = true
            shimmerMenuView.stop()
            tableView.isHidden = false
            errorMenuStateView.isHidden = true
            priceButton.isHidden = false
            addressButton.isHidden = false

        case .error:
            shimmerMenuView.isHidden = true
            shimmerMenuView.stop()
            tableView.isHidden = true
            errorMenuStateView.isHidden = false
            priceButton.isHidden = false
            addressButton.isHidden = false
        }
    }

    func reloadData() {
        tableView.reloadData()
    }

    func scrollToProduct(at index: Int) {
         let indexPath = IndexPath(row: index, section: MenuSection.products.rawValue)
         tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
     }

     func openProduct(_ product: Product) {
         let detailVC = di.screenFactory.makeDetailScreen(product)
         present(detailVC, animated: true)
     }
}

//MARK: - Table DataSource

extension MenuScreenVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSection.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let menuSection = MenuSection(rawValue: section) else { return 0 }
        
        switch menuSection {
        case .stories:
            return 1
        case .banners:
            return 1
        case .products:
            return (viewModel as? MenuViewModel)?.products.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let menuSection = MenuSection(rawValue: indexPath.section),
                let vm = viewModel as? MenuViewModel else {
            return UITableViewCell()
        }
        
        switch menuSection {
        case .stories:
            let cell = tableView.dequeueCell(indexPath) as StoryCell
            cell.update(vm.stories)
            cell.delegate = self
            return cell
        case .banners:
            let cell = tableView.dequeueCell(indexPath) as BannerCell
            cell.update(vm.banners)
            return cell
        case .products:
            let product = vm.products[indexPath.row]
            
            if product.isPromo == true {
                let promoCell = tableView.dequeueCell(indexPath) as PromoProductCell
                promoCell.update(product)
                return promoCell
            }
            let cell = tableView.dequeueCell(indexPath) as ProductCell
            cell.update(product)
            return cell
        }
    }
}

//MARK: - Table Delegate
extension MenuScreenVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard MenuSection(rawValue: indexPath.section) == .products else { return }
        viewModel.onProductSelected(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {

        guard MenuSection(rawValue: section) == .products,
              let vm = viewModel as? MenuViewModel,
              let header = tableView.dequeueHeaderFooter(
                ofType: CategoryContainerHeader.self
              ) else {
            return EmptyView()
        }

        header.update(vm.categories)
        header.onCategoryCellSelect = { [weak self] category in
            self?.viewModel.onCategorySelected(category)
        }

        return header
    }
}

//MARK: - Observers & Actions
extension MenuScreenVC {

    private func setupObservers() {
        errorMenuStateView.onRetryMenuPageTap = { [weak self] in
            self?.viewModel.onRetryTap()
        }

        priceButton.addAction(UIAction { [weak self] _ in
            self?.navigateToBasketScreen()
        }, for: .touchUpInside)

        addressButton.addAction(UIAction { [weak self] _ in
            self?.navigateToMapScreen()
        }, for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePriceButton), name: .basketUpdated, object: nil)
    }
}

//MARK: - Update priceButton
extension MenuScreenVC {
    
    @objc private func updatePriceButton() {
        let products = productStorage.retrieve()
        let totalPrice = totalPriceCounter.allProductsTotalPrice(products).0
        
        priceButton.isHidden = totalPrice == 0 ? true : false
        priceButton.setTitle("\(totalPrice) \u{20BD}", for: .normal)
    }
    
//    @objc private func updatePrice() {
//        let total = productsStorage.totalBasketPrice()
//        
//        priceButton.isHidden = total == 0 ? true : false
//        priceButton.setTitle("\(total) ₽", for: .normal)
//    }
}

//MARK: - Navigation
extension MenuScreenVC {

    private func navigateToBasketScreen() {
        let basketVC = di.screenFactory.makeBasketScreen()
        let nav = UINavigationController(rootViewController: basketVC)
        present(nav, animated: true)
    }

    private func navigateToMapScreen() {
        let mapVC = MapViewController()
        let nav = UINavigationController(rootViewController: mapVC)
        present(nav, animated: true)
    }
}

//MARK: - StoryNavigation
extension MenuScreenVC: StoryCellDelegate {
    func didSelectStory(_ story: Story, stories: [Story]) {
        let viewModel = StoriesViewModel(stories: stories, selectedStory: story)
        let vc = StoriesVC(viewModel: viewModel)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

//MARK: - Layout
extension MenuScreenVC {
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(priceButton)
        view.addSubview(addressButton)
        view.addSubview(errorMenuStateView)
        view.addSubview(shimmerMenuView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(56)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
        
        shimmerMenuView.snp.makeConstraints { make in
            make.edges.equalTo(tableView)
        }
        
        errorMenuStateView.snp.makeConstraints { make in
            make.edges.equalTo(tableView)
        }
        
        priceButton.snp.makeConstraints { make in
            make.right.equalTo(view).inset(16)
            make.bottom.equalTo(view).inset(48)
            make.height.equalTo(50)
        }
        
        addressButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(20)
        }
    }
}
