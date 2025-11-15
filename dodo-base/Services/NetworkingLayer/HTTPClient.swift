//
//  NetworkClient.swift
//  UIKitHomework
//
//  Created by Andrew on 02.10.2025.
//

import Foundation

//DIP - принцип инверсии зависимости
//SRP - принцип ответственности
protocol IHTTPClient {
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void)
    func fetch(url: URL) async throws -> Data
}


struct HTTPClient: IHTTPClient {
    func fetch(url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.requestError
        }
        
        return data
    }
    
    
    func fetch(url: URL, handler: @escaping (Result<Data, Error>) -> Void) {
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                handler(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                
                handler(.failure(NetworkError.statusCodeError))
                return
            }
            
            guard let data = data else { return }
            handler(.success(data))
        }
        
        task.resume()
    }
}
