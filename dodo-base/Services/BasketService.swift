//
//  BasketService.swift
//  UIKitHomework
//
//  Created by Andrew on 01.09.2025.
//

import Foundation


class BasketService {
    private let basket: [Basket] = [
        Basket(image: "cola", productLabel: "Добрый кола", weight: "0,5 л"),
        Basket(image: "dodster", productLabel: "Додстер", weight: "190 г"),
        Basket(image: "friesAndSauce", productLabel: "Картофель из печи с соусом", weight: "180 г")
    ]
    
    func fetchBasket() -> [Basket] {
        return basket
    }
}
