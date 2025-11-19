//
//  BasketVC.swift
//  UIKitHomework
//
//  Created by Andrew on 21.08.2025.
//

import UIKit
import SnapKit


private enum BasketState {
    case empty
    case filled
}


final class BasketVC: UIViewController {
    
    var products: [Product] = []
    var additions: [Product] = []
    
    var productsStorage: IProductsStorage
    var productsLoader: IProductsLoader
    
    init(productsStorage: IProductsStorage, productsLoader: IProductsLoader) {
        self.productsStorage = productsStorage
        self.productsLoader = productsLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var basketButtonView = BasketButtonView()
    private var emptyBasketView = EmptyBasketView()
    
    private lazy var basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        
        tableView.registerCell(TotalPriceCell.self)
        tableView.registerCell(BasketCell.self)
        tableView.registerCell(AddProductCell.self)
        
        return tableView
    }()
    
    private var state: BasketState = .empty {
        didSet { applyState() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        fetchAdditions()
        fetchBasket()
        updateState()
        setupObservers()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(basketTableView)
        basketTableView.isHidden = true
        view.addSubview(basketButtonView)
        view.addSubview(emptyBasketView)
        fetchBasket()
    }
    
    private func setupConstraints() {
        basketTableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(basketButtonView.snp.top)
        }
        
        basketButtonView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        emptyBasketView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func fetchAdditions() {
        Task {
            do {
                let additions = try await productsLoader.loadProducts()
                self.additions = additions
                self.basketTableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchBasket() {
        let array = productsStorage.retrieve()
        products = array
        basketTableView.reloadData()
        updateState()
    }
    
    private func updateState() {
        state = products.isEmpty ? .empty : .filled
    }
    
    private func applyState() {
        switch state {
        case .empty:
            emptyBasketView.isHidden = false
            basketTableView.isHidden = true
            basketButtonView.isHidden = true
            
        case .filled:
            emptyBasketView.isHidden = true
            basketTableView.isHidden = false
            basketButtonView.isHidden = false
        }
    }
    
    private func setupObservers() {
        emptyBasketView.onBackToMenuButtonTap = {
            self.dismiss(animated: true)
        }
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true)
    }
}

//MARK: - TableViewDataSource

extension BasketVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return products.count
        case 2: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = tableView.dequeueCell(indexPath) as TotalPriceCell
            return cell
        case 1:
            let cell = tableView.dequeueCell(indexPath) as BasketCell
            let product = products[indexPath.row]
            cell.update(product)
            
            
            cell.onCountChanged = { [weak self] updatedProduct, newCount in
                
                guard let self = self else { return }
                
                // 1) Обновляем storage
                self.productsStorage.update(updatedProduct, count: newCount)
                
                // 2) Обновляем локальную модель `products` чтобы UI сразу отразил изменения
                if let idx = self.products.firstIndex(where: { $0 == updatedProduct }) {
                    if newCount > 0 {
                        self.products[idx].count = newCount
                    } else {
                        self.products.remove(at: idx)
                    }
                } else if newCount > 0 {
                    // если продукта не было — добавим в локальную модель
                    var newP = updatedProduct
                    newP.count = newCount
                    self.products.append(newP)
                }
                
                // 3) Обновляем конкретную строку или весь раздел/таблицу.
                // Лучше обновить конкретную строку либо удалить/вставить.
                DispatchQueue.main.async {
                    // если newCount == 0 — удаляем строку
                    if newCount == 0 {
                        self.basketTableView.reloadData() // можно анимированно удалить row
                        self.updateState()
                    } else {
                        // обновляем строку
                        self.basketTableView.reloadRows(at: [indexPath], with: .none)
                    }
                    
                    // и обновим total price cell (section 0)
                    let totalIndexPath = IndexPath(row: 0, section: 0)
                    self.basketTableView.reloadRows(at: [totalIndexPath], with: .none)
                }
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueCell(indexPath) as AddProductCell
            cell.update(additions)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
