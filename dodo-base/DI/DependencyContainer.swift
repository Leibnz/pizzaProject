//
//  DependencyContainer.swift
//  UIKitHomework
//
//  Created by Andrew on 07.10.2025.
//

import Foundation
import UIKit

final class DependencyContainer {
    
    let decoder: JSONDecoder
    let productsLoader: IProductsLoader
    let bannersLoader: IBannersLoader
    let categoriesLoader: ICategoriesLoader
    let storiesLoader: IStoriesLoader
    let ingredientsLoader: IIngredientsLoader
    let productsStorage: IProductsStorage
    let totalPriceCounter: ITotalPriceCounter
    
    let httpClient: IHTTPClient
    
    let screenFactory: ScreenFactory
    
    init() {
        httpClient = HTTPClient()
        decoder = JSONDecoder()
        productsLoader = ProductsLoader(httpClient: httpClient, decoder: decoder)
        bannersLoader = BannersLoader(httpClient: httpClient, decoder: decoder)
        categoriesLoader = CategoriesLoader(httpClient: httpClient, decoder: decoder)
        storiesLoader = StoriesLoader(httpClient: httpClient, decoder: decoder)
        ingredientsLoader = IngredientsLoader(httpClient: httpClient, decoder: decoder)
        productsStorage = ProductsStorage()
        totalPriceCounter = TotalPriceCounter()

        
        screenFactory = ScreenFactory()
        screenFactory.di = self
    }
}

//MARK: Контейнер для создания всех экранов
final class ScreenFactory {
    
    weak var di: DependencyContainer!

    @MainActor
    func makeMenuScreen() -> UIViewController {
        MenuModuleBuilder.build(di: di)
    }
    
    func makeDetailScreen(_ product: Product) -> DetailProductVC {
        return DetailProductVC(product: product, ingredientsLoader: di.ingredientsLoader, productsStorage: di.productsStorage, totalPriceCounter: di.totalPriceCounter)
    }
    
    func makeBasketScreen() -> BasketVC {
        return BasketVC(productsStorage: di.productsStorage, productsLoader: di.productsLoader, totalPriceCounter: di.totalPriceCounter)
    }
}
