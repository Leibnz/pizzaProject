//
//  PizzaProjectTests.swift
//  PizzaProjectTests
//
//  Created by Andrew on 25.11.2025.
//

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
    
    @Test("loadBanners returns decoded banners")
    func testLoadBannersSuccess() async throws {
        
        let banners = [
            Banner(id: 1, image: "twopizzas", name: "2 pizzas", newPrice: 400),
            Banner(id: 2, image: "twosauces", name: "2 sauces", newPrice: 100)
        ]
        
        let jsonData = try JSONEncoder().encode(banners)
        let stub = StubHTTPClient(mode: .success(jsonData))
        
        let loader = BannersLoader(httpClient: stub, decoder: JSONDecoder())
        
        let result = try await loader.loadBanners()
        
        #expect(result == banners)
    }
    
    @Test("loadProducts returns decoded products")
    func testLoadProductsSuccess() async throws {
        
        let products = [
            Product(id: 1, name: "Гавайская", type: CategoryType.pizza, description: "Двойная порция цыпленка, ананасы", price: 300, image: "hawaii", isPromo: true),
            Product(id: 2, name: "Добрый Кола", type: CategoryType.drinks, description: "", price: 100, image: "cola", isPromo: false)
        ]
        
        let jsonData = try JSONEncoder().encode(products)
        let stub = StubHTTPClient(mode: .success(jsonData))
        
        let loader = ProductsLoader(httpClient: stub, decoder: JSONDecoder())
        
        let result = try await loader.loadProducts()
        
        #expect(result == products)
    }
    
    @Test("loadStories returns decoded stories")
    func testLoadStoriesSuccess() async throws {
        
        let stories = [
            Story(id: 1, image: "softDrinks", type: "story"),
            Story(id: 2, image: "internetProblems", type: "story")
        ]
        
        let jsonData = try JSONEncoder().encode(stories)
        let stub = StubHTTPClient(mode: .success(jsonData))
        
        let loader = StoriesLoader(httpClient: stub, decoder: JSONDecoder())
        
        let result = try await loader.loadStories()
        
        #expect(result == stories)
    }
}

//MARK: - Ingredients tests
@Test("loadIngredients throws on HTTP error")
func testLoadIngredientsHttpError() async {
    
    let stub = StubHTTPClient(mode: .failure(NetworkError.requestError))
    
    let loader = IngredientsLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.requestError) {
        _ = try await loader.loadIngredients()
    }
}

@Test("loadIngredients throws decodingError on invalid JSON")
func testLoadIngredientsDecodingError() async {
    
    let invalidJSON = Data("invalid json".utf8)
    let stub = StubHTTPClient(mode: .success(invalidJSON))
    
    let loader = IngredientsLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.decodingError) {
        _ = try await loader.loadIngredients()
    }
}

//MARK: - Banners tests
@Test("loadBanners throws on HTTP error")
func testLoadBannersHttpError() async {
    
    let stub = StubHTTPClient(mode: .failure(NetworkError.requestError))
    
    let loader = BannersLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.requestError) {
        _ = try await loader.loadBanners()
    }
}

@Test("loadIngredients throws decodingError on invalid JSON")
func testLoadBannersDecodingError() async {
    
    let invalidJSON = Data("invalid json".utf8)
    let stub = StubHTTPClient(mode: .success(invalidJSON))
    
    let loader = BannersLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.decodingError) {
        _ = try await loader.loadBanners()
    }
}

//MARK: - Products tests
@Test("loadProducts throws on HTTP error")
func testLoadProductsHttpError() async {
    
    let stub = StubHTTPClient(mode: .failure(NetworkError.requestError))
    
    let loader = ProductsLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.requestError) {
        _ = try await loader.loadProducts()
    }
}

@Test("loadProducts throws decodingError on invalid JSON")
func testLoadProductsDecodingError() async {
    
    let invalidJSON = Data("invalid json".utf8)
    let stub = StubHTTPClient(mode: .success(invalidJSON))
    
    let loader = ProductsLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.decodingError) {
        _ = try await loader.loadProducts()
    }
}

//MARK: - Stories tests
@Test("loadStories throws on HTTP error")
func testLoadStoriesHttpError() async {
    
    let stub = StubHTTPClient(mode: .failure(NetworkError.requestError))
    
    let loader = StoriesLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.requestError) {
        _ = try await loader.loadStories()
    }
}

@Test("loadStories throws decodingError on invalid JSON")
func testLoadStoriesDecodingError() async {
    
    let invalidJSON = Data("invalid json".utf8)
    let stub = StubHTTPClient(mode: .success(invalidJSON))
    
    let loader = StoriesLoader(httpClient: stub, decoder: JSONDecoder())
    
    await #expect(throws: NetworkError.decodingError) {
        _ = try await loader.loadStories()
    }
}
