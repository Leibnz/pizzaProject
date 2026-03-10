//
//  MenuModuleBuilder.swift
//  PizzaProject
//
//  Created by Andrew on 08.03.2026.
//

import Foundation
import UIKit

final class MenuModuleBuilder {

    @MainActor static func build(di: DependencyContainer) -> UIViewController {

        let interactor = MenuInteractor(
            productsLoader: di.productsLoader,
            bannersLoader: di.bannersLoader,
            categoriesLoader: di.categoriesLoader,
            storiesLoader: di.storiesLoader
        )

        let router = MenuRouter(screenFactory: di.screenFactory)

        let presenter = MenuPresenter(
            interactor: interactor,
            router: router
        )

        let view = MenuScreenVC(
            presenter: presenter,
            productsStorage: di.productsStorage
        )

        presenter.view = view
        router.viewController = view

        return view
    }
}
