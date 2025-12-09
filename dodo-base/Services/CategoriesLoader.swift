//
//  TypeService.swift
//  UIKitHomework
//
//  Created by Andrew on 07.08.2025.
//

import Foundation


protocol ICategoriesLoader {
    func loadCategories() async throws -> [Category]
}

struct CategoriesLoader: ICategoriesLoader {
    
    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    private var categoriesURL: URL {
        guard let url = URL(string: "http://localhost:3001/categories") else {
            preconditionFailure("Unable to construct categoriesURL")
        }
        return url
    }
    
    func loadCategories() async throws -> [Category] {
        
        let data = try await httpClient.fetch(url: categoriesURL)
        
        do {
            let categories = try decoder.decode([Category].self, from: data)
            return categories
        } catch {
            throw NetworkError.decodingError
        }
    }
}
