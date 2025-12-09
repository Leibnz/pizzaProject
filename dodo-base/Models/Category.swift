//
//  Type.swift
//  UIKitHomework
//
//  Created by Andrew on 07.08.2025.
//

import UIKit

enum CategoryType: String, Codable {
    case pizza = "pizza"
    case combo = "combo"
    case snacks = "snacks"
    case cocktails = "cocktails"
    case coffee = "coffee"
    case drinks = "drinks"
    case sauces = "sauces"
}

struct Category: Codable, Equatable {
    var name: String
    var isSelected: Bool
    let type: CategoryType
}
