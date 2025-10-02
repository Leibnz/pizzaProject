//
//  ExtraService.swift
//  UIKitHomework
//
//  Created by Andrew on 19.08.2025.
//

import Foundation


class ExtraService {
    
    private let extras: [Extra] = [
        Extra(image: "bacon", name: "Бекон", price: 79),
//        Extra(image: "beef", name: "Пряная говядина", price: 119),
//        Extra(image: "cheddarCheese", name: "Cыр чеддер", price: 79),
        Extra(image: "cheeseSide", name: "Сырный бортик", price: 179),
        Extra(image: "chicken", name: "Нежный цыпленок", price: 79),
        Extra(image: "jalapeno", name: "Острый перец халапеньо", price: 59),
        Extra(image: "mozzarella", name: "Моцарелла", price: 79),
        Extra(image: "tomato", name: "Свежие томаты", price: 59)
//        Extra(image: "champignons", name: "Шампиньоны", price: 59)
    ]
    
    func fetchExtras() -> [Extra] {
        return extras
    }
}
