//
//  MenuRouter.swift
//  PizzaProject
//
//  Created by Andrew on 08.03.2026.
//

import Foundation
import UIKit

protocol IMenuRouter {
    func openProduct(_ product: Product)
    func openBasket()
    func openMap()
    func openStories(stories: [Story], selected: Story)
}

final class MenuRouter: IMenuRouter {

    weak var viewController: UIViewController?
    private let screenFactory: ScreenFactory

    init(screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
    }

    func openProduct(_ product: Product) {
        let vc = screenFactory.makeDetailScreen(product)
        viewController?.present(vc, animated: true)
    }

    func openBasket() {
        let vc = screenFactory.makeBasketScreen()
        let nav = UINavigationController(rootViewController: vc)
        viewController?.present(nav, animated: true)
    }

    func openMap() {
        let vc = MapViewController()
        let nav = UINavigationController(rootViewController: vc)
        viewController?.present(nav, animated: true)
    }

    func openStories(stories: [Story], selected: Story) {
        let viewModel = StoriesViewModel(stories: stories, selectedStory: selected)
        let vc = StoriesVC(viewModel: viewModel)
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true)
    }
}
