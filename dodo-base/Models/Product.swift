//
//  Product.swift
//  UIKitHomework
//
//  Created by Andrew on 23.07.2025.
//

import UIKit

struct Product: Decodable {
    var id: Int
    var name: String
    var type: String
    var description: String
    var price: Int
    var image: String
    var size: Int?
    var dough: String?
    var count: Int?
}
