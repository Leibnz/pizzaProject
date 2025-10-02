//
//  NetworkError.swift
//  UIKitHomework
//
//  Created by Andrew on 21.09.2025.
//

import Foundation


enum NetworkError: Error {
    case badUrl
    case requestError
    case clientError
    case serverError
    case decodingError
}
