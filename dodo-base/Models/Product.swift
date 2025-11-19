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
    var type: String
    var description: String
    var price: Int
    var image: String
    var size: Int?
    var dough: DoughType?
    var count: Int?
    var isPromo: Bool
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
}


enum DoughType: String, Codable {
    case traditional
    case thin
    
    func getIndex() -> Int {
        return self == DoughType.traditional ? 0 : 1
    }
    
    func getName() -> String {
        return self == DoughType.traditional ? "Традиционное" : "Тонкое"
    }
}
