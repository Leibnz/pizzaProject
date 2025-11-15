//
//  BasketVC.swift
//  UIKitHomework
//
//  Created by Andrew on 21.08.2025.
//

import UIKit
import SnapKit


final class BasketVC: UIViewController {
    
    private var basketButtonView = BasketButtonView()
    
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
    
    private lazy var basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.dataSource = self
        
        tableView.registerCell(TotalPriceCell.self)
        tableView.registerCell(BasketCell.self)
        tableView.registerCell(AddProductCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        fetchAdditions()
        fetchBasket()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(basketTableView)
        view.addSubview(basketButtonView)
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
