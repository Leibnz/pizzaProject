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
    
    let httpClient: IHTTPClient
    
    let screenFactory: ScreenFactory
    
    init() {
        httpClient = HTTPClient()
        decoder = JSONDecoder()
        productsLoader = ProductsLoader(httpClient: httpClient, decoder: decoder)
        bannerLoader = BannerLoader(httpClient: httpClient, decoder: decoder)
        categoryLoader = CategoryLoader(httpClient: httpClient, decoder: decoder)
        storiesLoader = StoriesLoader()

        
        screenFactory = ScreenFactory()
        screenFactory.di = self
    }
}

//Контейнер для создания все экранов
final class ScreenFactory {
    
    weak var di: DependencyContainer!

    func makeMenuScreen() -> MenuScreenVC {
        return MenuScreenVC(productLoader: di.productsLoader, bannerLoader: di.bannerLoader, categoryLoader: di.categoryLoader, storiesLoader: di.storiesLoader)
    }
    
    func makeDetailScreen() -> DetailProductVC {
        return DetailProductVC()
    }
}





////SRP
////-> Module Configure
//final class MenuConfigurator {
//    func configure() -> MenuScreenVC {
//
//        let session = URLSession.shared
//        let decoder = JSONDecoder()
//        let productsLoader = ProductsLoader(session: session, decoder: decoder)
//        let menuVC = MenuScreenVC.init(productsLoader: productsLoader)
//
//        return menuVC
//    }
//}
