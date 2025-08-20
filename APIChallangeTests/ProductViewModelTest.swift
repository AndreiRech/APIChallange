//
//  ProductViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 20/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct ProductViewModelSwiftTests {
    private let database: SwiftDataServiceProtocol = MockSwiftDataService()
    
    @Test func fetchProducts() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service, database: database)
        
        
        // When
        await viewModel.getProducts()
        await viewModel.getProduct(by: 1)
        
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
//        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func fetchOneProduct() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service, database: database)
        
        
        // When
        await viewModel.getProduct(by: 1)
        
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
//        #expect(viewModel.errorMessage == nil)
    }
    
    @Test func fetchProductsShouldFail() async throws {
        
        // Given
        let service = MockProductService(shouldFail: true)
        let viewModel = ProductViewModel(service: service, database: database)
        
        // When
        await viewModel.getProducts()
        
        
        // Then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.product == nil)
//        #expect(viewModel.errorMessage != nil)
        
    }
    
    @Test func addProductToFavorite() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service, database: database)
        
        await viewModel.getProducts()
        viewModel.addToFavorite(product: viewModel.products.first!)
        
        #expect(database.fetchFavoriteProducts().count == 1)
    }
    
    @Test func removeProductFromFavorite() async throws {
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service, database: database)
        
        await viewModel.getProducts()
        viewModel.addToFavorite(product: viewModel.products.first!)
        viewModel.removeFromFavorite(product: viewModel.products.first!)
        
        #expect(database.fetchFavoriteProducts().count == 0)
    }
    
    @Test func addProductToOrder() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service, database: database)
        
        await viewModel.getProducts()
        viewModel.addToOrder(product: viewModel.products.first!)
        
        #expect(database.fetchOrderProducts().count == 1)
    }
    
    @Test func addProductToCart() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let viewModel = ProductViewModel(service: service, database: database)
        
        await viewModel.getProducts()
        viewModel.addToCart(product: viewModel.products.first!)
        
        #expect(database.fetchCartProducts().count == 1)
    }    
}
