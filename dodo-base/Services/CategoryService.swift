//
//  TypeService.swift
//  UIKitHomework
//
//  Created by Andrew on 07.08.2025.
//

import Foundation

protocol ICategoriesLoader {
    func fetchCategories() -> [Category]
}

class CategoryLoader: ICategoriesLoader {
    
    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    private let categories: [Category] = [
        Category(name: "Пиццы", isSelected: false),
        Category(name: "Комбо", isSelected: true),
        Category(name: "Закуски", isSelected: false),
        Category(name: "Коктейли", isSelected: false),
        Category(name: "Кофе", isSelected: false),
        Category(name: "Напитки", isSelected: false),
        Category(name: "Соусы", isSelected: false)
    ]
    
    func fetchCategories() -> [Category] {
        return categories
    }
}
