//
//  TotalPriceCounter.swift
//  PizzaProject
//
//  Created by Andrew on 17.02.2026.
//

import Foundation

protocol ITotalPriceCounter {
    func totalProductPrice(_ product: Product) -> Int
    func allProductsTotalPrice(_ products: [Product]) -> (Int, Int)
}

final class TotalPriceCounter: ITotalPriceCounter {
    
    func totalProductPrice(_ product: Product) -> Int {
        var totalSum = product.price
        
        for ingredient in product.ingredients ?? [] {
            totalSum += ingredient.price
            
        }
        
        totalSum *= product.count ?? 1
        return totalSum
    }
    
    func allProductsTotalPrice(_ products: [Product]) -> (Int, Int) {
        var totalSum = 0
        var totalCount = 0
        
        for product in products {
            totalSum += totalProductPrice(product)
            totalCount += 1
        }
        
        return (totalSum, totalCount)
    }
    
    
}
