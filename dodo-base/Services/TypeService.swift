//
//  TypeService.swift
//  UIKitHomework
//
//  Created by Andrew on 07.08.2025.
//

import Foundation


class TypeService {
    
    private let types: [Type] = [
        Type(name: "Пиццы", isSelected: false),
        Type(name: "Комбо", isSelected: true),
        Type(name: "Закуски", isSelected: false),
        Type(name: "Коктейли", isSelected: false),
        Type(name: "Кофе", isSelected: false),
        Type(name: "Напитки", isSelected: false),
        Type(name: "Соусы", isSelected: false)
    ]
    
    func fetchTypes() -> [Type] {
        return types
    }
}
