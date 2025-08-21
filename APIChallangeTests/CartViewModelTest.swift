//
//  FavoriteViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 20/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct CartViewModelSwiftTests {
    private let database: SwiftDataServiceProtocol = MockSwiftDataService()
    
    @Test func fetchCartEmpty() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = CartViewModel(database: database)
        
        
        // When
        await productViewModel.getProducts()
        viewModel.loadCartProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum == 0)
    }
    
    @Test func fetchCart() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = CartViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToCart(product: productViewModel.product!)
        
        viewModel.loadCartProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum != 0)
    }
    
    @Test func calculeteTotalSum() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = CartViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToCart(product: productViewModel.product!)
        viewModel.loadCartProducts(allProducts: productViewModel.products)
        viewModel.calculateTotalSum()
        
        
        // Then
        #expect(viewModel.totalSum != 0)
    }
    
    @Test func getQuantityById() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = CartViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToCart(product: productViewModel.product!)
        viewModel.loadCartProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(viewModel.getQuantity(by: productViewModel.product!.id) != 0)
    }
}

