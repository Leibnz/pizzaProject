//
//  ViewController.swift
//  UIKitHomework
//
//  Created by Andrew on 20.07.2025.
//

import UIKit
import SnapKit


private enum MenuScreenState {
    case initial
    case loading
    case loaded
    case error
}


final class MenuScreenVC: UIViewController {
    
    private var priceButton = PriceButton(price: "270 \u{20BD}")
    private var addressButton = AddressButton()
    
    var products: [Product] = []
    var categories: [Category] = []
    var banners: [Banner] = []
    var stories: [Story] = []
    
    private let productsLoader: IProductsLoader
    private let bannersLoader: IBannersLoader
    private let categoriesLoader: ICategoriesLoader
    private let storiesLoader: IStoriesLoader
    
    init(productLoader: IProductsLoader, bannerLoader: IBannersLoader, categoryLoader: ICategoriesLoader, storiesLoader: IStoriesLoader) {
        self.productsLoader = productLoader
        self.bannersLoader = bannerLoader
        self.categoriesLoader = categoryLoader
        self.storiesLoader = storiesLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let errorMenuStateView = ErrorMenuStateView()
    private let shimmerMenuView = ShimmerMenuView()
    
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
        tableView.register(CategoryContainerHeader.self, forHeaderFooterViewReuseIdentifier: CategoryContainerHeader.reuseId)
        tableView.registerCell(StoryCell.self)
        return tableView
    }()
    
    private var state: MenuScreenState = .initial {
        didSet { applyState() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupActions()
        
        loadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.shimmerMenuView.start()
        }
    }
    
    private func loadData() {
        state = .loading
        
        Task {
            do {
                async let p = productsLoader.loadProducts()
                async let b = bannersLoader.loadBanners()
                async let s = storiesLoader.loadStories()
                
                let products = try await p
                let banners = try await b
                let stories = try await s
                
                self.products = products
                self.banners = banners
                self.stories = stories
                self.categories = categoriesLoader.fetchCategories()
                
                tableView.reloadData()
                state = .loaded
            } catch {
                state = .error
            }
        }
    }
}


//MARK: - Setup
extension MenuScreenVC {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(priceButton)
        view.addSubview(addressButton)
        view.addSubview(errorMenuStateView)
        view.addSubview(shimmerMenuView)
        
        errorMenuStateView.isHidden = true
        shimmerMenuView.isHidden = true
        
        errorMenuStateView.onRetryMenuPageTap = { [weak self] in
            self?.loadData()
        }
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
    
    private func setupActions() {
        priceButton.addAction(UIAction(handler: { [weak self] _ in
            let basketVC = di.screenFactory.makeBasketScreen()
            
            let navController = UINavigationController(rootViewController: basketVC)
            
            // Настройка кнопки "Закрыть"
            basketVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: basketVC, action: #selector(basketVC.closeTapped)
            )
            basketVC.navigationItem.leftBarButtonItem?.tintColor = .orange
            
            // Заголовок по центру
            basketVC.navigationItem.title = "Корзина"
            
            self?.present(navController, animated: true)
        }), for: .touchUpInside)
        
        addressButton.addAction(UIAction(handler: { [weak self] _ in
            let mapVC = MapViewController()
            
            let navController = UINavigationController(rootViewController: mapVC)
            
            // Настройка кнопки "Закрыть"
            mapVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Закрыть", style: .plain, target: mapVC, action: #selector(mapVC.closeTapped)
            )
            mapVC.navigationItem.leftBarButtonItem?.tintColor = .orange
            
            // Заголовок по центру
            mapVC.navigationItem.title = "Карта"
            
            self?.present(navController, animated: true)
        }), for: .touchUpInside)
    }
    
    private func applyState() {
        switch state {
            
        case .initial:
            shimmerMenuView.isHidden = false
            shimmerMenuView.start()
            
            tableView.isHidden = true
            errorMenuStateView.isHidden = true
            priceButton.isHidden = true
            addressButton.isHidden = true
            
        case .loading:
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
    
}

//MARK: - TableViewDataSource and TableViewDelegate
enum MenuSection: Int, CaseIterable {
    case stories
    case banners
    case products
}


extension MenuScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuSection.allCases.count
    }

    //Метод датасорса - Возвращаем количество ячеек в таблице в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let menuSection = MenuSection.init(rawValue: section) else { return 0 }
        
        switch menuSection {
        case .stories:
            return 1
        case .banners:
            return 1
        case .products:
            return products.count
        }
    }
    
    //Метод датасорса - Возвращаем конкретную ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let menuSection = MenuSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch menuSection {
        case .stories:
            let cell = tableView.dequeueCell(indexPath) as StoryCell
            cell.update(stories)
            return cell
        case .banners:
            let cell = tableView.dequeueCell(indexPath) as BannerCell
            cell.update(banners)
            return cell
        case .products:
            let product = products[indexPath.row]
            
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let menuSection = MenuSection.init(rawValue: section) else {
            return nil
        }
        
        switch menuSection {
        case .products:
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryContainerHeader.reuseId) as? CategoryContainerHeader else {
                return UIView()
            }
            
            header.update(categories)
            header.onCategoryCellSelect = { category in
                switch category.name {
                case "Пиццы":
                    let indexPath = IndexPath(row: 0, section: 2)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                case "Комбо":
                    let indexPath = IndexPath(row: 6, section: 2)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                case "Закуски":
                    let indexPath = IndexPath(row: 9, section: 2)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                case "Коктейли":
                    let indexPath = IndexPath(row: 12, section: 2)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                case "Кофе":
                    let indexPath = IndexPath(row: 15, section: 2)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                case "Напитки":
                    let indexPath = IndexPath(row: 18, section: 2)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                case "Соусы":
                    let indexPath = IndexPath(row: 22, section: 2)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
                default:
                    break
                }
            }
            return header
            

        default:
            return EmptyView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let menuSection = MenuSection(rawValue: indexPath.section) else {
            return
        }
        
        switch menuSection {
        case .products:
            let product = products[indexPath.row]
            let detailVC = di.screenFactory.makeDetailScreen(product)
            self.present(detailVC, animated: true)
        default: break
        }
    }
}
