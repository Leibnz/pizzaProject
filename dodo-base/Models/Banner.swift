//
//  Banner.swift
//  UIKitHomework
//
//  Created by Andrew on 08.08.2025.
//

import UIKit


struct Banner: Codable, Equatable {
    var id: Int
    var image: String
    var name: String
    var newPrice: Int
    var oldPrice: Int?
}
