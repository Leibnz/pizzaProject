//
//  StoriesService.swift
//  UIKitHomework
//
//  Created by Andrew on 09.08.2025.
//

import Foundation

protocol IStoriesLoader {
    func loadStories() async throws -> [Story]
}

struct StoriesLoader: IStoriesLoader {
    
    private let httpClient: IHTTPClient
    private let decoder: JSONDecoder
    
    init(httpClient: IHTTPClient, decoder: JSONDecoder) {
        self.httpClient = httpClient
        self.decoder = decoder
    }
    
    private var storiesURL: URL {
        guard let url = URL(string: "http://localhost:3001/stories") else {
            preconditionFailure("Unable to construct storiesURL")
        }
        return url
    }
    
    func loadStories() async throws -> [Story] {
        let data = try await httpClient.fetch(url: storiesURL)
        do {
            let stories = try decoder.decode([Story].self, from: data)
            return stories
        } catch {
            throw NetworkError.decodingError
        }
    }
}
