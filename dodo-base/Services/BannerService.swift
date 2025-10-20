//
//  BannerService.swift
//  UIKitHomework
//
//  Created by Andrew on 08.08.2025.
//

import Foundation

protocol IBannersLoader {
    func loadBanners() async throws -> [Banner]
}

class BannerLoader: IBannersLoader {
    
    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }

    func loadBanners() async throws -> [Banner] {
        guard let url = URL(string: "http://localhost:3001/banners") else {
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
            let banners = try decoder.decode([Banner].self, from: data)
            return banners
        } catch {
            throw NetworkError.decodingError
        }
    }
    
    
    func loadBanners(completion: @escaping (Result<[Banner], NetworkError>) -> Void) {
        guard let url = URL(string: "http://localhost:3001/banners") else {
            completion(.failure(.badUrl))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.requestError))
                return
            }

            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    break
                case 400..<500:
                    completion(.failure(.clientError))
                    return
                case 500..<600:
                    completion(.failure(.serverError))
                    return
                default:
                    break
                }
            }

            guard let data = data else {
                completion(.failure(.requestError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let banners = try decoder.decode([Banner].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(banners))
                }
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }

        task.resume()
    }
}


    
