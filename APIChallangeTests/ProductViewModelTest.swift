//
//  ProductViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 20/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct ProductViewModelTests {
    @Test func fetchProducts() async throws {
        // Given
        let viewModel = ProductViewModel(productService: MockProductService(), favoriteService: MockFavoriteService(), cartService: MockCartService(), orderService: MockOrderService())
        
        
        // When
        await viewModel.getProducts()
        await viewModel.getProduct(by: 1)
        
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
    }
    
    @Test func fetchOneProduct() async throws {
        
        // Given
        let viewModel = ProductViewModel(productService: MockProductService(), favoriteService: MockFavoriteService(), cartService: MockCartService(), orderService: MockOrderService())
        
        
        // When
        await viewModel.getProduct(by: 1)
        
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
    }
    
    @Test func fetchProductsShouldFail() async throws {
        
        // Given
        let viewModel = ProductViewModel(productService: MockProductService(shouldFail: true), favoriteService: MockFavoriteService(), cartService: MockCartService(), orderService: MockOrderService())
        
        // When
        await viewModel.getProducts()
        
        
        // Then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.product == nil)        
    }
    
    @Test func addProductToFavorite() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        let viewModel = ProductViewModel(productService: MockProductService(), favoriteService: mockFavoriteService, cartService: MockCartService(), orderService: MockOrderService())
        
        await viewModel.getProducts()
        viewModel.addToFavorite(product: viewModel.products.first!)
        
        #expect(!mockFavoriteService.favorites.isEmpty)
    }
    
    @Test func removeProductFromFavorite() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService(startEmpty: true)
        let viewModel = ProductViewModel(productService: MockProductService(), favoriteService: mockFavoriteService, cartService: MockCartService(), orderService: MockOrderService())
        
        await viewModel.getProducts()
        viewModel.addToFavorite(product: viewModel.products.first!)
        
        #expect(!mockFavoriteService.favorites.isEmpty)
        
        viewModel.removeFromFavorite(product: viewModel.products.first!)
        
        #expect(mockFavoriteService.favorites.isEmpty)
    }
    
    @Test func addProductToOrder() async throws {
        // Given
        let mockOrderService = MockOrderService()
        let viewModel = ProductViewModel(productService: MockProductService(), favoriteService: MockFavoriteService(), cartService: MockCartService(), orderService: mockOrderService)
        
        await viewModel.getProducts()
        viewModel.addToOrder(product: viewModel.products.first!)
        
        #expect(!mockOrderService.orders.isEmpty)
    }
    
    @Test func addProductToCart() async throws {
        // Given
        let mockCartService = MockCartService()
        let viewModel = ProductViewModel(productService: MockProductService(), favoriteService: MockFavoriteService(), cartService: mockCartService, orderService: MockOrderService())
        
        await viewModel.getProducts()
        viewModel.addToCart(product: viewModel.products.first!)
        
        #expect(!mockCartService.carts.isEmpty)
        
    }
}
