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
        array.append(product)
        save(array)
    }
}
