//
//  DependencyContainer.swift
//  UIKitHomework
//
//  Created by Andrew on 07.10.2025.
//

import Foundation

final class DependencyContainer {
    
    let decoder: JSONDecoder
    let productsLoader: IProductsLoader
    let bannerLoader: IBannersLoader
    let categoryLoader: ICategoriesLoader
    let storiesLoader: IStoriesLoader
    let ingredientsLoader: IIngredientsLoader
    let productsStorage: IProductsStorage
    
    let httpClient: IHTTPClient
    
    let screenFactory: ScreenFactory
    
    init() {
        httpClient = HTTPClient()
        decoder = JSONDecoder()
        productsLoader = ProductsLoader(httpClient: httpClient, decoder: decoder)
        bannerLoader = BannersLoader(httpClient: httpClient, decoder: decoder)
        categoryLoader = CategoriesLoader(httpClient: httpClient, decoder: decoder)
        storiesLoader = StoriesLoader(httpClient: httpClient, decoder: decoder)
        ingredientsLoader = IngredientsLoader(httpClient: httpClient, decoder: decoder)
        productsStorage = ProductsStorage()

        
        screenFactory = ScreenFactory()
        screenFactory.di = self
    }
}

//MARK: Контейнер для создания всех экранов
final class ScreenFactory {
    
    weak var di: DependencyContainer!

    @MainActor func makeMenuScreen() -> MenuScreenVC {
        let viewModel = MenuViewModel(
            productLoader: di.productsLoader,
            bannerLoader: di.bannerLoader,
            categoryLoader: di.categoryLoader,
            storiesLoader: di.storiesLoader
        )
        
        return MenuScreenVC(viewModel: viewModel)
    }
    
    func makeDetailScreen(_ product: Product) -> DetailProductVC {
        return DetailProductVC(product: product, ingredientsLoader: di.ingredientsLoader, productsStorage: di.productsStorage)
    }
    
    func makeBasketScreen() -> BasketVC {
        return BasketVC(productsStorage: di.productsStorage, productsLoader: di.productsLoader)
    }
}
