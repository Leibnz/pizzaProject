//
//  ViewModel.swift
//  PizzaProject
//
//  Created by Andrew on 21.12.2025.
//

import Foundation

@MainActor
protocol MenuViewModelInput {
    func onViewDidLoad()
    func onRetryTap()
    func onProductSelected(index: Int)
    func onCategorySelected(_ category: Category)
}

protocol MenuViewModelOutput: AnyObject {
    func render(state: MenuScreenState)
    func reloadData()
    func scrollToProduct(at index: Int)
    func openProduct(_ product: Product)
}

@MainActor
final class MenuViewModel {
    
    weak var output: MenuViewModelOutput?
    
    private(set) var state: MenuScreenState = .initial
    private(set) var products: [Product] = []
    private(set) var categories: [Category] = []
    private(set) var banners: [Banner] = []
    private(set) var stories: [Story] = []
    
    private let productsLoader: IProductsLoader
    private let bannersLoader: IBannersLoader
    private let categoriesLoader: ICategoriesLoader
    private let storiesLoader: IStoriesLoader
    
    init(productLoader: IProductsLoader, bannerLoader: IBannersLoader, categoryLoader: ICategoriesLoader, storiesLoader: IStoriesLoader) {
        self.productsLoader = productLoader
        self.bannersLoader = bannerLoader
        self.categoriesLoader = categoryLoader
        self.storiesLoader = storiesLoader
    }
}

extension MenuViewModel: MenuViewModelInput {

    func onViewDidLoad() {
        loadData()
    }

    func onRetryTap() {
        loadData()
    }

    func onProductSelected(index: Int) {
        let product = products[index]
        output?.openProduct(product)
    }

    func onCategorySelected(_ category: Category) {
        guard let index = products.firstIndex(where: { $0.type == category.type }) else {
            return
        }
        output?.scrollToProduct(at: index)
    }

    private func loadData() {
        updateState(.loading)

        Task {
            do {
                async let products = productsLoader.loadProducts()
                async let banners = bannersLoader.loadBanners()
                async let categories = categoriesLoader.loadCategories()
                async let stories = storiesLoader.loadStories()

                self.products = try await products
                self.banners = try await banners
                self.categories = try await categories
                self.stories = try await stories

                updateState(.loaded)
                output?.reloadData()
            } catch {
                updateState(.error)
            }
        }
    }

    private func updateState(_ newState: MenuScreenState) {
        state = newState
        output?.render(state: newState)
    }
}
