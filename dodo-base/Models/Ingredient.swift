//
//  Ingredient.swift
//  UIKitHomework
//
//  Created by Andrew on 19.08.2025.
//

import UIKit

struct Ingredient: Codable, Equatable {
    let image: String
    let name: String
    let price: Int
    
    let isSelected: Bool
    
    var selected: Ingredient {
        return Ingredient(image: image, name: name, price: price, isSelected: !isSelected)
    }
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.image == rhs.image && lhs.name == rhs.name && lhs.price == rhs.price
    }
}
