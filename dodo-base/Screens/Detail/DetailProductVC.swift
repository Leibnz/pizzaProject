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
    
    private var isPizza: Bool {
        product.type == .pizza
    }
    
    private var ingredients: [Ingredient] = []
    
    private let ingredientsLoader: IIngredientsLoader
    private var product: Product
    private let productsStorage: IProductsStorage
    private let totalPriceCounter: ITotalPriceCounter
    
    init(product: Product, ingredientsLoader: IIngredientsLoader, productsStorage: IProductsStorage, totalPriceCounter: ITotalPriceCounter) {
        self.product = product
        self.ingredientsLoader = ingredientsLoader
        self.productsStorage = productsStorage
        self.totalPriceCounter = totalPriceCounter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let orderButtonView = OrderButtonView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.dataSource = self
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
        setupObservers()
        fetchIngredients()
        updateTotalPrice(product.price)
    }
}

//MARK: - Business logic
extension DetailProductVC {
    
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
}

//MARK: - Table DataSource
extension DetailProductVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isPizza {
            return DetailSection.allCases.count
        } else {
            return 2
        }
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
            cell.onIngredientSelect = { [weak self] index in
                guard let self else { return }
                ingredients[index] = self.ingredients[index].selected
            
                tableView.reloadData()
                
                let selectedIngredients = self.ingredients.filter { $0.isSelected == true }
                self.product.ingredients = selectedIngredients
                
                self.totalPrice(self.product)
            }
            return cell
        }
    }
}

//MARK: - Observers
extension DetailProductVC {
    
    private func setupObservers() {
        orderButtonView.onOrderButtonTap = { [weak self] in
            guard let self else { return }
            self.productsStorage.add(self.product)
        }
    }
}

//MARK: - Update Total Price
extension DetailProductVC {
    
    func totalPrice(_ product: Product) {
        var totalSum = 0
        for ingredient in product.ingredients ?? [] {
            totalSum += ingredient.price
        }
        totalSum += product.price
        updateTotalPrice(totalSum)
    }

    func updateTotalPrice(_ totalSum: Int) {
        orderButtonView.orderButton.setTitle("Оформить заказ за \(totalSum) ₽", for: .normal)
    }
}

//MARK: - Layout
extension DetailProductVC {
    
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
