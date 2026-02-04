//
//  DadataService.swift
//  PizzaProject
//
//  Created by Andrew on 23.12.2025.
//

import Foundation

//struct DadataResponse: Decodable {
//    let suggestions: [DadataSuggestion]
//}
//
//struct DadataSuggestion: Decodable {
//    let value: String
//}
//
//final class DadataService {
//    static let shared = DadataService()
//    private init() {}
//    
//    private let apiKey = "d64380eaa70ff998908fcc9d53c2a30a31252e65"
//    private let baseURL = URL(string: "https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address")!
//    
//    func suggestAddress(
//        query: String,
//        completion: @escaping (Result<[DadataSuggestion], Error>) -> Void
//    ) {
//        var request = URLRequest(url: baseURL)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
//        
//        let body: [String: Any] = [
//            "query": query,
//            "count": 5
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
//        
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            
//            if let error = error {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            do {
//                let response = try JSONDecoder().decode(DadataResponse.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(response.suggestions))
//                }
//            } catch {
//                DispatchQueue.main.async {
//                    completion(.failure(error))
//                }
//            }
//        }.resume()
//    }
//}
