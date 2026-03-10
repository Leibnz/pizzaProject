//
//  MenuPresenter.swift
//  PizzaProject
//
//  Created by Andrew on 05.03.2026.
//

import Foundation

@MainActor
final class MenuPresenter {

    weak var view: IMenuScreenInput?

    private let interactor: IMenuInteractor
    private let router: IMenuRouter

    private(set) var products: [Product] = []
    private(set) var categories: [Category] = []
    private(set) var banners: [Banner] = []
    private(set) var stories: [Story] = []

    init(
        interactor: IMenuInteractor,
        router: IMenuRouter
    ) {
        self.interactor = interactor
        self.router = router
    }
}

extension MenuPresenter: IMenuScreenOutput {

    func viewDidLoad() {
        loadMenu()
    }

    func retryLoad() {
        loadMenu()
    }

    func didSelectProduct(at index: Int) {
        guard products.indices.contains(index) else { return }
        router.openProduct(products[index])
    }

    func didSelectStory(_ story: Story, stories: [Story]) {
        router.openStories(stories: stories, selected: story)
    }

    func didSelectCategory(_ category: Category) {
        guard let index = products.firstIndex(where: { $0.type == category.type }) else {
            return
        }

        view?.scrollToProduct(at: index)
    }

    func numberOfProducts() -> Int {
        products.count
    }

    func product(at index: Int) -> Product {
        return products[index]
    }

    func showBanners() -> [Banner] {
        return banners
    }

    func showStories() -> [Story] {
        return stories
    }

    func showCategories() -> [Category] {
        return categories
    }
}

private extension MenuPresenter {

    func loadMenu() {
        
        view?.render(state: .loading)

        Task {
            do {
                let data = try await interactor.loadMenu()
            
                products = data.products
                banners = data.banners
                categories = data.categories
                stories = data.stories

                view?.reloadData()
                view?.render(state: .loaded)

            } catch {
                
                view?.render(state: .error)
            }
        }
    }
}
