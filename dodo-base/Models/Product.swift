//
//  Product.swift
//  UIKitHomework
//
//  Created by Andrew on 23.07.2025.
//

import UIKit

struct Product: Codable, Equatable {
    var id: Int
    var name: String
    var type: CategoryType
    var description: String
    var price: Int
    var image: String
    var size: PizzaSize?
    var dough: PizzaDough?
    var ingredients: [Ingredient]?
    var count: Int?
    var isPromo: Bool
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type && lhs.ingredients == rhs.ingredients
    }
}

extension Product {
    static func stub(
        id: Int = 0,
        type: CategoryType = .pizza,
        isPromo: Bool = false
    ) -> Product {
        Product(id: id, name: "Test", type: type, description: "cheese", price: 100, image: "test.png", isPromo: isPromo)
    }
}
