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
    
    @Test func iPadTopPicksShouldReturnFirst4SortedAlphabetically() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        
        let productsInit = [
            Product(id: 1, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 2, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 3, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 4, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 5, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 6, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 7, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
        ]
        
        let mockProductService = MockProductService(products: productsInit)
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)

        let products = try await mockProductService.getProducts()
        viewModel.products = products
        
        // When
        let topPicks = viewModel.iPadTopPicks
        
        // Then
        #expect(topPicks.count == 4)
        let sorted = products.sorted { $0.title < $1.title }
        #expect(topPicks == Array(sorted.prefix(4)))
    }

    @Test func iPadBestSellersShouldReturnProductsAfterTop4() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        
        let productsInit = [
            Product(id: 1, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 2, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 3, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 4, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 5, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 6, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 7, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
        ]
        
        let mockProductService = MockProductService(products: productsInit)
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)

        let products = try await mockProductService.getProducts()
        viewModel.products = products
        
        // When
        let bestSellers = viewModel.iPadBestSellers
        
        // Then
        #expect(bestSellers != nil)
        let sorted = products.sorted { $0.title > $1.title }
        #expect(bestSellers == Array(sorted.dropFirst(4)))
    }

    @Test func iPadDealsOfTheDayShouldReturnFirst2Products() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        
        let productsInit = [
            Product(id: 1, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 2, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 3, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 4, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 5, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 6, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"),
            Product(id: 7, title: "title", description: "description", category: "beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
        ]
        
        let mockProductService = MockProductService(products: productsInit)
        let viewModel = HomeViewModel(favoriteService: mockFavoriteService, productService: mockProductService)

        let products = try await mockProductService.getProducts()
        viewModel.products = products
        
        // When
        let deals = viewModel.iPadDealsOfTheDay
        
        // Then
        #expect(deals != nil)
        #expect(deals?.count == 2)
        #expect(deals == Array(products.prefix(2)))
    }

}
