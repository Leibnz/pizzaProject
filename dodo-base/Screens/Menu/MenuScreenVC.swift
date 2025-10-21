//
//  ViewController.swift
//  UIKitHomework
//
//  Created by Andrew on 20.07.2025.
//

import UIKit
import SnapKit

final class MenuScreenVC: UIViewController {
    
    private var priceButton = PriceButton(price: "270 \u{20BD}")
    private var addressButton = AddressButton()
    
    var products: [Product] = []
    var types: [Type] = []
    var banners: [Banner] = []
    var stories: [Story] = []
    
    let productsLoader: IProductsLoader
    let bannersLoader: IBannersLoader
    let categoriesLoader: ICategoriesLoader
    let storiesLoader: IStoriesLoader
    
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
    
//    let productService = ProductService.init()
//    let httpClient = HTTPClient()
//    let decoder = JSONDecoder()
//    private lazy var productsLoader = ProductsLoader(httpClient: httpClient, decoder: decoder)
//    let typeService = TypeService.init()
//    let bannerService = BannerService.init()
//    let storiesService = StoriesService.init()
    
    private lazy var tableView: UITableView = {
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        
        $0.registerCell(ProductCell.self)
        $0.registerCell(BannerCell.self)
        $0.registerCell(TypeCell.self)
        $0.registerCell(StoriesCell.self)
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupActions()
        
        
        fetchProducts()
        fetchTypes()
        fetchBanners()
        fetchStories()
        
    }
    
    private func fetchProducts() {
        Task {
            do {
                let products = try await productsLoader.loadProducts()
                self.products = products
                self.tableView.reloadData()
            } catch {
                print("Error")
            }
        }
    }
    
//    private func fetchProducts() {
//        productsLoader.loadProducts { result in
//            switch result {
//            case .success(let products):
//                self.products = products
//                self.tableView.reloadData()
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//    }
    
//    private func fetchProducts() {
//        Task {
//            do {
//                let products = try await productService.loadProducts()
//                self.products = products
//                self.tableView.reloadData()
//            } catch NetworkError.badUrl {
//                print("Bad URL")
//            } catch NetworkError.requestError {
//                print("Request Error")
//            } catch NetworkError.clientError {
//                print("Client Error")
//            } catch NetworkError.serverError {
//                print("Server Error")
//            } catch NetworkError.decodingError {
//                print("Decoding Error")
//            }
//        }
//    }
    
//    private func fetchProducts() {
//        productService.loadProducts { result in
//            switch result {
//                
//            case .success(let products):
//                self.products = products
//                self.tableView.reloadData()
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func fetchTypes() {
        types = categoriesLoader.fetchTypes()
        tableView.reloadData() //Лучше обновлять не всю View, а только секцию
    }
    
//    private func fetchBanners() {
//        bannerService.loadBanners { result in
//            switch result {
//                
//            case .success(let banners):
//                self.banners = banners
//                self.tableView.reloadData()
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    private func fetchBanners() {
        Task {
            do {
                let banners = try await bannersLoader.loadBanners()
                self.banners = banners
                self.tableView.reloadData()
            } catch NetworkError.badUrl {
                print("Bad URL")
            } catch NetworkError.requestError {
                print("Request Error")
            } catch NetworkError.clientError {
                print("Client Error")
            } catch NetworkError.serverError {
                print("Server Error")
            } catch NetworkError.decodingError {
                print("Decoding Error")
            }
        }
    }
    
    private func fetchStories() {
        Task {
            do {
                let stories = try await storiesLoader.loadStories()
                self.stories = stories
                self.tableView.reloadData()
            } catch NetworkError.badUrl {
                print("Bad URL")
            } catch NetworkError.requestError {
                print("Request Error")
            } catch NetworkError.clientError {
                print("Client Error")
            } catch NetworkError.serverError {
                print("Server Error")
            } catch NetworkError.decodingError {
                print("Decoding Error")
            }
        }
    }

//    private func fetchStories() {
//        storiesService.loadStories { result in
//            switch result {
//            
//            case .success(let stories):
//                self.stories = stories
//                self.tableView.reloadData()
//            
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
}

extension MenuScreenVC {
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(priceButton)
        view.addSubview(addressButton)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(56)
            make.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
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
            let basketVC = BasketVC()
            
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
            self?.present(mapVC, animated: true)
        }), for: .touchUpInside)
    }
}

//MARK: - TableViewDataSource and TableViewDelegate
extension MenuScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    //Метод датасорса - Возвращаем количество ячеек в таблице в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        case 3: return products.count
        default: return 0
        }
        
    }
    
    //Метод датасорса - Возвращаем конкретную ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = tableView.dequeueCell(indexPath) as StoriesCell
            cell.update(stories)
            return cell
        case 1:
            let cell = tableView.dequeueCell(indexPath) as BannerCell
            cell.update(banners)
            return cell
        case 2:
            let cell = tableView.dequeueCell(indexPath) as TypeCell
            cell.update(types)
            return cell
        case 3:
            let cell = tableView.dequeueCell(indexPath) as ProductCell
            let product = products[indexPath.row]
            cell.update(product)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        switch section {
        case 3:
            let detailVC = DetailProductVC()
            self.present(detailVC, animated: true)
        default: break
        }
    }
}


