//
//  PizzaDough.swift
//  UIKitHomework
//
//  Created by Andrew on 22.10.2025.
//

import Foundation

enum PizzaDough: String, Codable {
    case traditional
    case thin
    
    func getIndex() -> Int {
        return self == PizzaDough.traditional ? 0 : 1
    }
    
    func getName() -> String {
        return self == PizzaDough.traditional ? "Традиционное" : "Тонкое"
    }
}
