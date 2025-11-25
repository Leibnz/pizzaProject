//
//  ProductsLoader.swift
//  UIKitHomework
//
//  Created by Andrew on 02.10.2025.
//

import Foundation


protocol IProductsLoader {
//    func loadProducts(handler: @escaping (Result<[Product], Error>) -> Void)
    func loadProducts() async throws -> [Product]
}


struct ProductsLoader: IProductsLoader {

    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    private var productsURL: URL {
        guard let url = URL(string: "http://localhost:3001/products") else {
            preconditionFailure("Unable to construct productsURL")
        }
        return url
    }
    
    func loadProducts() async throws -> [Product] {
        
        let data = try await httpClient.fetch(url: productsURL)
        
        do {
            
            let products = try decoder.decode([Product].self, from: data)
            return products
        } catch {
            print(error.localizedDescription)
            throw NetworkError.decodingError
        }
    }
    
//    func loadProducts(handler: @escaping (Result<[Product], any Error>) -> Void) {
//        
//        httpClient.fetch(url: productsURL) { result in
//            switch result {
//            case .success(let data):
//                do {
//                    let products = try decoder.decode([Product].self, from: data)
//                    DispatchQueue.main.async {
//                        handler(.success(products))
//                    }
//                } catch {
//                    handler(.failure(error))
//                }
//                
//            case .failure(let error):
//                handler(.failure(error))
//            }
//        }
//    }
}
