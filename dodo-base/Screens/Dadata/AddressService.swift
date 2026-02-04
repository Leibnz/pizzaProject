//
//  DadataService.swift
//  PizzaProject
//
//  Created by Andrew on 27.12.2025.
//

import Foundation

protocol AddressServiceProtocol {
    func fetchSuggestions(query: String, completion: @escaping (Result<[AddressSuggestion], Error>) -> Void)
}

final class AddressService: AddressServiceProtocol {
    
    private let apiKey = "d64380eaa70ff998908fcc9d53c2a30a31252e65"
    
    func fetchSuggestions(query: String, completion: @escaping (Result<[AddressSuggestion], any Error>) -> Void) {
        
        guard let url = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["query": query]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else { return }
            
            do {
                let response = try JSONDecoder().decode(AddressResponse.self, from: data)
                completion(.success(response.suggestions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
