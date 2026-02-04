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

struct BannersLoader: IBannersLoader {
    
    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    private var bannersURL: URL {
        guard let url = URL(string: "http://localhost:3001/banners") else {
            preconditionFailure("Unable to construct bannersURL")
        }
        return url
    }

    func loadBanners() async throws -> [Banner] {
        let data = try await httpClient.fetch(url: bannersURL)
        do {
            let banners = try decoder.decode([Banner].self, from: data)
            return banners
        } catch {
            throw NetworkError.decodingError
        }
    }
}


    
