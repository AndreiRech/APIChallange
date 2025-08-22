//
//  FavoriteViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 21/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct FavoriteViewModelTests {
    @Test func fetchFavorites() async throws {
        // Given
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        // When
        let products = try await mockProductService.getProducts()
        viewModel.loadFavoriteProducts(allProducts: products)
        
        // Then
        #expect(!viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func removeFavoriteProduct() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        let product = Product(id: 1, title: "", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        viewModel.loadFavoriteProducts(allProducts: [product])
        
        let firstProductId = viewModel.favoriteProducts[0].id
        
        viewModel.favoriteProducts.remove(at: 0)
        mockFavoriteService.remove(firstProductId)
        
        #expect(viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func addFavoriteProduct() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        let products = try await mockProductService.getProducts()
        let product = Product(id: 1, title: "", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        
        mockFavoriteService.add(product.id)
        
        viewModel.loadFavoriteProducts(allProducts: products)
        
        #expect(!viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func isFavoriteProduct() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        
        let products = try await mockProductService.getProducts()
        
        viewModel.loadFavoriteProducts(allProducts: products)
        
        let firstProductId = viewModel.favoriteProducts[0].id
        #expect(viewModel.isFavorite(firstProductId))
        
        let lastProductId = viewModel.favoriteProducts[viewModel.favoriteProducts.count - 1].id
        #expect(viewModel.isFavorite(lastProductId))
    }
    
    @Test func filteredProducts_searchText() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        let products = [
            Product(id: 1, title: "Apple", description: "", category: "", price: 1, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "Banana", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        ]
        mockFavoriteService.add(1)
        mockFavoriteService.add(2)
        
        viewModel.loadFavoriteProducts(allProducts: products)
        viewModel.searchText = "apple"
        
        #expect(viewModel.filteredProducts.count == 1)
        #expect(viewModel.filteredProducts[0].title == "Apple")
    }
    
    @Test func filteredProducts_emptySearchText() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService, productService: mockProductService)
        let products = [
            Product(id: 1, title: "Apple", description: "", category: "", price: 1, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "Banana", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        ]
        mockFavoriteService.add(1)
        mockFavoriteService.add(2)
        
        viewModel.loadFavoriteProducts(allProducts: products)
        viewModel.searchText = ""
        
        #expect(viewModel.filteredProducts.count == 2)
        #expect(viewModel.filteredProducts[0].title == "Apple")
        #expect(viewModel.filteredProducts[1].title == "Banana")
    }
    
    @Test func getAllFavoritesProducts() async throws {
        let mockFavoriteService = MockFavoriteService()
        let mockProductService = MockProductService()
        
        let allProducts: [Product] = [
            Product(id: 1, title: "A", description: "", category: "", price: 10, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "B", description: "", category: "", price: 20, shippingInformation: "", thumbnail: ""),
            Product(id: 99, title: "C", description: "", category: "", price: 30, shippingInformation: "", thumbnail: "")
        ]
        
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService,
                                          productService: mockProductService)

        #expect(viewModel.favoriteProducts.isEmpty)
        
        mockFavoriteService.add(1)
        mockFavoriteService.add(2)

        await viewModel.getProducts()
        viewModel.loadFavoriteProducts(allProducts: allProducts)

        #expect(viewModel.favoriteProducts.count == 2)
    }
    
    @Test func getFavoriteProduct() async throws {
        // Given
        let allProducts: [Product] = [
            Product(id: 1, title: "A", description: "", category: "", price: 10, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "B", description: "", category: "", price: 20, shippingInformation: "", thumbnail: ""),
            Product(id: 99, title: "C", description: "", category: "", price: 30, shippingInformation: "", thumbnail: "")
        ]

        let mockFavoriteService = MockFavoriteService()
        mockFavoriteService.add(allProducts[0].id)

        let mockProductService = MockProductService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService,
                                          productService: mockProductService)

        #expect(viewModel.favoriteProducts.isEmpty)

        // When
        await viewModel.getProducts()
        viewModel.loadFavoriteProducts(allProducts: viewModel.products)
        await viewModel.getProduct(by: 1)

        // Then
        #expect(viewModel.favoriteProducts.count == 1)
        #expect(viewModel.favoriteProducts.first?.id == 1)
        #expect(viewModel.product?.id == 1)
        #expect(viewModel.isFavorite(1))
    }
    
    @Test func getProductWhenProductsEmpty() async throws {
        let mockProductService = MockProductService()
        let mockFavoriteService = MockFavoriteService()
        let viewModel = FavoriteViewModel(favoriteService: mockFavoriteService, productService: mockProductService)

        #expect(viewModel.products.isEmpty)

        await viewModel.getProduct(by: 1)

        #expect(viewModel.product?.id == 1)
    }
}
