//
//  FavoriteViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 20/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct FavoriteViewModelSwiftTests {
    private let database: SwiftDataServiceProtocol = MockSwiftDataService()
    
    @Test func fetchFavoritesEmpty() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = FavoriteViewModel(database: database)
        
        
        // When
        await productViewModel.getProducts()
        viewModel.loadFavoriteProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func fetchFavorites() async throws {
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = FavoriteViewModel(database: database)
        
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToFavorite(product: productViewModel.product!)
        
        viewModel.loadFavoriteProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(!viewModel.favoriteProducts.isEmpty)
    }
    
    @Test func isFavorite() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = FavoriteViewModel(database: database)
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToFavorite(product: productViewModel.product!)
        viewModel.loadFavoriteProducts(allProducts: productViewModel.products)
        
        
        // Then
        #expect(viewModel.isFavorite(viewModel.favoriteProducts[0].id) == true)
        
    }
    
    @Test func filterFavoritesEmpty() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = FavoriteViewModel(database: database)
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToFavorite(product: productViewModel.product!)
        viewModel.loadFavoriteProducts(allProducts: productViewModel.products)
        viewModel.searchText = "ZZZZZ"
        
        // Then
        #expect(viewModel.filteredProducts.isEmpty)
        
    }
    
    @Test func filterFavoritesOneItem() async throws {
        
        // Given
        let service = MockProductService(shouldFail: false)
        let productViewModel = ProductViewModel(service: service, database: database)
        let viewModel = FavoriteViewModel(database: database)
        
        // When
        await productViewModel.getProduct(by: 1)
        productViewModel.addToFavorite(product: productViewModel.product!)
        viewModel.loadFavoriteProducts(allProducts: productViewModel.products)
        viewModel.searchText = "e"
        
        // Then
        #expect(!viewModel.filteredProducts.isEmpty)
        
    }
}

