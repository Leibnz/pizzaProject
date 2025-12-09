//
//  PizzaSize.swift
//  UIKitHomework
//
//  Created by Andrew on 22.10.2025.
//

import Foundation


enum PizzaSize: Int, Codable {
    case small = 20
    case medium = 25
    case large = 30
    case extraLarge = 35
    
    func getSize() -> String {
        switch self {
        case .small:
            return "20 см"
        case .medium:
            return "25 см"
        case .large:
            return "30 см"
        case .extraLarge:
            return "35 см"
        }
    }
    
    func setIndex(index: Int) -> Self {
        switch index {
        case 0:
            return .small
        case 1:
            return .medium
        case 2:
            return .large
        case 3:
            return .extraLarge
        default:
            return self
        }
    }
    
    func getIndex() -> Int {
        switch self {
        case .small:
            return 0
        case .medium:
            return 1
        case .large:
            return 2
        case .extraLarge:
            return 3
        }
    }
}
