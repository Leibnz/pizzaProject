//
//  DependencyContainer.swift
//  UIKitHomework
//
//  Created by Andrew on 07.10.2025.
//

import Foundation


final class DependencyContainer {
    
    let session: URLSession
    let decoder: JSONDecoder
    let productsLoader: ProductsLoader
//    let bannersLoader: BannersLoader
//    let categoriesLoader: CategoriesLoader
    
    let screenFactory: ScreenFactory
    
    init() {
        session = URLSession.shared
        decoder = JSONDecoder()
//        productsLoader = ProductsLoader(session: session, decoder: decoder)
//        bannersLoader = BannersLoader(session: session, decoder: decoder)
//        categoriesLoader = CategoriesLoader(session: session, decoder: decoder)
        
        
        
        screenFactory = ScreenFactory()
        screenFactory.di = self
    }
}

//Контейнер для создания все экранов
final class ScreenFactory {
    
    weak var di: DependencyContainer!

    func makeMenuScreen() -> MenuScreenVC {
        return MenuScreenVC(productsLoader: di.productsLoader) //bannersLoader: di.bannersLoader, categoriesLoader: di.categoriesLoader)
        
        //return MenuScreenVC(provider: di.menuProvider)
    }
    
    //func makeDetailScreen() -> DetailScreenVC { }
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
