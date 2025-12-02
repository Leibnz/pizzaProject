//
//  DetailProductVC.swift
//  UIKitHomework
//
//  Created by Andrew on 13.08.2025.
//

import UIKit
import SnapKit

private enum DetailSection: Int, CaseIterable {
    case pizzaImage
    case pizzaInfo
    case optionsPizza
    case ingredientsPizza
}

final class DetailProductVC: UIViewController {
    
    private var ingredients: [Ingredient] = []
    
    private let ingredientsLoader: IIngredientsLoader
    private let product: Product
    private let productsStorage: IProductsStorage
    
    init(product: Product, ingredientsLoader: IIngredientsLoader, productsStorage: IProductsStorage) {
        self.product = product
        self.ingredientsLoader = ingredientsLoader
        self.productsStorage = productsStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var orderButtonView = OrderButtonView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(PizzaImageCell.self)
        tableView.registerCell(PizzaInfoCell.self)
        tableView.registerCell(OptionsPizzaCell.self)
        tableView.registerCell(IngredientsCell.self)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupObservers() //установка наблюдателей
        
        fetchIngredients()
    }
    
    private func setupObservers() {
        //realization
        orderButtonView.onOrderButtonTap = {
            self.productsStorage.add(self.product)
        }
    }
    
    private func fetchIngredients() {
        Task {
            do {
                let ingredients = try await ingredientsLoader.loadIngredients()
                self.ingredients = ingredients
                self.tableView.reloadData()
            } catch {
                print("Error")
            }
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(orderButtonView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        orderButtonView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}


//MARK: - TableViewDataSource and TableViewDelegate
extension DetailProductVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let detailSection = DetailSection.init(rawValue: section) else { return 0 }
        
        switch detailSection {
        case .pizzaImage:
            return 1
        case .pizzaInfo:
            return 1
        case .optionsPizza:
            return 1
        case .ingredientsPizza:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let detailSection = DetailSection(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch detailSection {
        case .pizzaImage:
            let cell = tableView.dequeueCell(indexPath) as PizzaImageCell
            cell.update(product)
            return cell
        case .pizzaInfo:
            let cell = tableView.dequeueCell(indexPath) as PizzaInfoCell
            cell.update(product)
            return cell
        case .optionsPizza:
            let cell = tableView.dequeueCell(indexPath) as OptionsPizzaCell
            return cell
        case .ingredientsPizza:
            let cell = tableView.dequeueCell(indexPath) as IngredientsCell
            cell.update(ingredients)
            return cell
        }
    }
}
