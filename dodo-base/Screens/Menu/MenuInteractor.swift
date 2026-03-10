//
//  MenuInteractor.swift
//  PizzaProject
//
//  Created by Andrew on 05.03.2026.
//

import Foundation

protocol IMenuInteractor {
    func loadMenu() async throws -> MenuData
}

struct MenuData {
    let products: [Product]
    let banners: [Banner]
    let categories: [Category]
    let stories: [Story]
}

final class MenuInteractor: IMenuInteractor {

    private let productsLoader: IProductsLoader
    private let bannersLoader: IBannersLoader
    private let categoriesLoader: ICategoriesLoader
    private let storiesLoader: IStoriesLoader

    init(
        productsLoader: IProductsLoader,
        bannersLoader: IBannersLoader,
        categoriesLoader: ICategoriesLoader,
        storiesLoader: IStoriesLoader
    ) {
        self.productsLoader = productsLoader
        self.bannersLoader = bannersLoader
        self.categoriesLoader = categoriesLoader
        self.storiesLoader = storiesLoader
    }

    func loadMenu() async throws -> MenuData {
        
        async let products = productsLoader.loadProducts()
        async let banners = bannersLoader.loadBanners()
        async let categories = categoriesLoader.loadCategories()
        async let stories = storiesLoader.loadStories()

        return try await MenuData(
            products: products,
            banners: banners,
            categories: categories,
            stories: stories
        )
    }
}
