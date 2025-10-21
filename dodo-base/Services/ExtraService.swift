//
//  ExtraService.swift
//  UIKitHomework
//
//  Created by Andrew on 19.08.2025.
//

import Foundation


protocol IExtrasLoader {
    func loadExtras() async throws -> [Extra]
}


struct ExtraLoader: IExtrasLoader {

    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    private var extrasURL: URL {
        guard let url = URL(string: "http://localhost:3001/extras") else {
            preconditionFailure("Unable to construct extrasURL")
        }
        return url
    }
    
    func loadExtras() async throws -> [Extra] {
        
        let data = try await httpClient.fetch(url: extrasURL)
        
        do {
            
            let extras = try decoder.decode([Extra].self, from: data)
            return extras
        } catch {
            throw NetworkError.decodingError
        }
    }
}




//class ExtraService {
//    
//    private let extras: [Extra] = [
//        Extra(image: "bacon", name: "Бекон", price: 79),
//        Extra(image: "cheeseSide", name: "Сырный бортик", price: 179),
//        Extra(image: "chicken", name: "Нежный цыпленок", price: 79),
//        Extra(image: "jalapeno", name: "Острый перец халапеньо", price: 59),
//        Extra(image: "mozzarella", name: "Моцарелла", price: 79),
//        Extra(image: "tomato", name: "Свежие томаты", price: 59)
//        Extra(image: "beef", name: "Пряная говядина", price: 119),
//        Extra(image: "cheddarCheese", name: "Cыр чеддер", price: 79),
//        Extra(image: "champignons", name: "Шампиньоны", price: 59)
//    ]
//    
//    func fetchExtras() -> [Extra] {
//        return extras
//    }
//}
