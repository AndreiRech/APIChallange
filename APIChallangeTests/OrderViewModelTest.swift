//
//  FavoriteViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 20/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct OrderViewModelSwiftTests {
    private let database: SwiftDataServiceProtocol = MockSwiftDataService()
    
    @Test func fetchOrderEmpty() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = OrderViewModel(database: database)
        
        
        // When
        await productViewModel.getProducts()
        viewModel.loadOrderProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(viewModel.orderProducts.isEmpty)
    }
    
    @Test func fetchOrder() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = OrderViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToOrder(product: productViewModel.product!)
        
        viewModel.loadOrderProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(!viewModel.orderProducts.isEmpty)
    }
    
    @Test func filterOrderNoSearch() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = OrderViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToOrder(product: productViewModel.product!)
        viewModel.loadOrderProducts(allProducts: productViewModel.products)
        
        // Then
        #expect(!viewModel.filteredProducts.isEmpty)
        
    }
    
    @Test func filterOrderEmpty() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = OrderViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToOrder(product: productViewModel.product!)
        viewModel.loadOrderProducts(allProducts: productViewModel.products)
        viewModel.searchText = "ZZZZZ"
        
        // Then
        #expect(viewModel.filteredProducts.isEmpty)
        
    }
    
    @Test func filterOrderOneItem() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = OrderViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToOrder(product: productViewModel.product!)
        viewModel.loadOrderProducts(allProducts: productViewModel.products)
        viewModel.searchText = "e"
        
        // Then
        #expect(!viewModel.filteredProducts.isEmpty)
        
    }
}

