//
//  Product.swift
//  UIKitHomework
//
//  Created by Andrew on 23.07.2025.
//

import UIKit

struct Product: Codable {
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
