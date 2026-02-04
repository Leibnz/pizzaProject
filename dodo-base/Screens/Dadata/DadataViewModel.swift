//
//  DadataViewModel.swift
//  PizzaProject
//
//  Created by Andrew on 27.12.2025.
//

import Foundation

final class DadataViewModel {
    
    private let service: AddressServiceProtocol
    private(set) var suggestions: [AddressSuggestion] = []
    
    private(set) var isLoading: Bool = false
    
    var onUpdate: (() -> Void)?
    
    init(service: AddressServiceProtocol = AddressService()) {
        self.service = service
    }
    
    func search(text: String) {
        guard text.count > 2 else {
            isLoading = false
            suggestions = []
            onUpdate?()
            return
        }
        
        isLoading = true
        onUpdate?()

        service.fetchSuggestions(query: text) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                self.isLoading = false
                
                switch result {
                case .success(let suggestions):
                    self.suggestions = suggestions
                case .failure:
                    self.suggestions = []
                }
                self.onUpdate?()
            }
        }
    }

    func suggestion(at index: Int) -> String {
        suggestions[index].value
    }
}
