//
//  IngredientService.swift
//  UIKitHomework
//
//  Created by Andrew on 19.08.2025.
//

import Foundation


protocol IIngredientsLoader {
    func loadIngredients() async throws -> [Ingredient]
}

struct IngredientsLoader: IIngredientsLoader {

    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    private var ingredientsURL: URL {
        guard let url = URL(string: "http://localhost:3001/extras") else {
            preconditionFailure("Unable to construct extrasURL")
        }
        return url
    }
    
    func loadIngredients() async throws -> [Ingredient] {
        
        let data = try await httpClient.fetch(url: ingredientsURL)
        
        do {
            let ingredients = try decoder.decode([Ingredient].self, from: data)
            return ingredients
        } catch {
            throw NetworkError.decodingError
        }
    }
}
