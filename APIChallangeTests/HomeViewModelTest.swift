//
//  HomeViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 21/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct HomeViewModelTests {
    @Test func fetchFavorites() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        // When
        let products = try await mockProductService.getProducts()
        viewModel.loadFavoriteProducts(allProducts: products)
        
        // Then
        #expect(!viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func fetchFavoritesShouldFail() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService(shouldFail: true)
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        // When
        await viewModel.getProducts()
        
        // Then
        #expect(viewModel.favoriteProducts.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test func removeFavoriteProduct() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        let products = try await mockProductService.getProducts()
        let product = Product(id: 1, title: "", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        
        #expect(viewModel.favoriteProducts.isEmpty)
        
        viewModel.addToFavorite(product: product)
        viewModel.loadFavoriteProducts(allProducts: products)
        
        #expect(!viewModel.favoriteProducts.isEmpty)
        
        viewModel.removeFromFavorite(product: product)
        
        #expect(viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func addFavoriteProduct() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        let products = try await mockProductService.getProducts()
        let product = Product(id: 1, title: "", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        
        #expect(viewModel.favoriteProducts.isEmpty)
        
        viewModel.addToFavorite(product: product)
        
        viewModel.loadFavoriteProducts(allProducts: products)
        
        #expect(!viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func isFavoriteProduct() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        let products = try await mockProductService.getProducts()
        
        viewModel.loadFavoriteProducts(allProducts: products)
        
        let firstProductId = viewModel.favoriteProducts[0].id
        #expect(viewModel.isFavorite(firstProductId))
        
        let lastProductId = viewModel.favoriteProducts[viewModel.favoriteProducts.count - 1].id
        #expect(viewModel.isFavorite(lastProductId))
    }
    
    @Test func fetchOneProduct() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        // When
        await viewModel.getProduct(by: 1)
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
    }
}
