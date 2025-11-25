//
//  File.swift
//  PizzaProject
//
//  Created by Andrew on 25.11.2025.
//

/*
import Testing
import Foundation
@testable import PizzaProject


final class StubHTTPClient: IHTTPClient {

    enum StubMode {
        case success(Data)
        case failure(Error)
    }
    
    private let mode: StubMode
    
    init(mode: StubMode) {
        self.mode = mode
    }
    
    func fetch(url: URL) async throws -> Data {
        switch mode {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
}

struct PizzaProjectTests {

    @Test("loadIngredients returns decoded ingredients")
    func testLoadIngredientsSuccess() async throws {
        
        let ingredients = [
            Ingredient(image: "cheese", name: "Cheese", price: 450),
            Ingredient(image: "tomato", name: "Tomato", price: 250)
        ]
        
        let jsonData = try JSONEncoder().encode(ingredients)
        let stub = StubHTTPClient(mode: .success(jsonData))
        
        let loader = IngredientsLoader(httpClient: stub, decoder: JSONDecoder())
        
        let result = try await loader.loadIngredients()
        
        #expect(result == ingredients)
    }
}


@Test("loadIngredients throws on HTTP error")
func testLoadIngredientsHttpError() async {
    
    let stub = StubHTTPClient(mode: .failure(NetworkError.requestError))
    
    let loader = IngredientsLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.requestError) {
        _ = try await loader.loadIngredients()
    }
}
*/
