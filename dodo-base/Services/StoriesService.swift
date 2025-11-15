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

class StoriesLoader: IStoriesLoader {
    
    func loadStories() async throws -> [Story] {
        guard let url = URL(string: "http://localhost:3001/stories") else {
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
            let stories = try decoder.decode([Story].self, from: data)
            return stories
        } catch {
            throw NetworkError.decodingError
        }
    }
}
