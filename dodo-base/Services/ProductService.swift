//
//  ProductService.swift
//  UIKitHomework
//
//  Created by Andrew on 23.07.2025.
//

import Foundation


class ProductService {
    
    func loadProducts() async throws -> [Product] {
        guard let url = URL(string: "http://localhost:3001/products") else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.requestError
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            break
        case 400..<500:
            throw NetworkError.clientError
        case 500..<600:
            throw NetworkError.serverError
        default:
            throw NetworkError.requestError
        }
        
        do {
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            return products
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    //    func loadProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
    //        guard let url = URL(string: "http://localhost:3001/products") else {
    //            completion(.failure(.badUrl))
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "GET"
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let error {
    //                completion(.failure(.requestError))
    //                return
    //            }
    //
    //            if let response = response as? HTTPURLResponse {
    //                switch response.statusCode {
    //                case 200..<300:
    //                    break
    //                case 400..<500:
    //                    completion(.failure(.clientError))
    //                    return
    //                case 500..<600:
    //                    completion(.failure(.serverError))
    //                    return
    //                default:
    //                    break
    //                }
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.requestError))
    //                return
    //            }
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                let products = try decoder.decode([Product].self, from: data)
    //                DispatchQueue.main.async {
    //                    completion(.success(products))
    //                }
    //            } catch {
    //                completion(.failure(.decodingError))
    //            }
    //        }
    //
    //        task.resume()
    //    }
}


