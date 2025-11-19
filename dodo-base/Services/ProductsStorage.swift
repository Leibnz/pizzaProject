//
//  ProductsStorage.swift
//  UIKitHomework
//
//  Created by Andrew on 11.11.2025.
//

import Foundation


//Класс-сервис - бизнес-логика - архивируем массив продуктов

protocol IProductsStorage {
    func save(_ products: [Product]) //сохраняем друзей
    func retrieve() -> [Product] //закдалываем их массивом
    func add(_ product: Product)
    func update(_ product: Product, count: Int)
    func remove(_ product: Product)
}

final class ProductsStorage: IProductsStorage {
    
    private let encoder = JSONEncoder() //кодирует в бинарник
    private let decoder = JSONDecoder() //разкодирует
    
    private let key = "Products"
    
    //MARK: - Public methods
    func save(_ products: [Product]) { //метод сохранить
        
        //Array<Product> -> Data
        //массив кладем в бинарник и кодируем, бинарник кладем в UserDefaults
        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    //retrieve - получить данные
    func retrieve() -> [Product] {  //метод получить
        
        //Data -> Array<Product>
        //вытаскиваем из UserDefaults бинарник
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            //раскодировали бинарник в массив
            let array = try decoder.decode(Array<Product>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    func add(_ product: Product) {
        var array = retrieve()
        
        if let index = array.firstIndex(where: { $0 == product }) {
            if let count = array[index].count {
                array[index].count = count + 1
            }
        } else {
            var newProduct = product
            newProduct.count = 1
            array.append(newProduct)
        }
        
//        array.append(product)
        save(array)
    }
    
    func update(_ product: Product, count: Int) {
        var array = retrieve()
        if let index = array.firstIndex(where: { $0 == product }) {
            if count > 0 {
                array[index].count = count
            } else {
                array.remove(at: index)
            }
            save(array)
        } else {
            // если продукта нет и count > 0 — добавить
            if count > 0 {
                var newProduct = product
                newProduct.count = count
                array.append(newProduct)
                save(array)
            }
        }
    }
    
    func remove(_ product: Product) {
        var array = retrieve()
        if let index = array.firstIndex(where: { $0 == product }) {
            array.remove(at: index)
            save(array)
        }
    } 
}
