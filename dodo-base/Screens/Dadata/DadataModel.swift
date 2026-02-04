//
//  DadataModel.swift
//  PizzaProject
//
//  Created by Andrew on 27.12.2025.
//

import Foundation

struct AddressSuggestion: Decodable {
    let value: String
}

struct AddressResponse: Decodable {
    let suggestions: [AddressSuggestion]
}
