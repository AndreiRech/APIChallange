//
//  CategoryProductsViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 15/08/25.
//

import Foundation
import SwiftUI

@Observable
class CategoryProductsViewModel: CategoryProductsViewModelProtocol {
    private var favoriteService: FavoriteServiceProtocol
    private var productService: ProductsServiceProtocol
    var category: ProductCategory
    
    var favoriteProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var product: Product?
    var products: [Product] = []
    var searchText: String = ""
    
    init(favoriteService: FavoriteServiceProtocol, productService: ProductsServiceProtocol, category: ProductCategory) {
        self.favoriteService = favoriteService
        self.productService = productService
        self.category = category
    }
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return products.filter { $0.category == category.rawValue.lowercased() }
        } else {
            return products.filter { $0.category == category.rawValue.lowercased() && $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func loadFavoriteProducts(allProducts: [Product]) {
        let storedFavorites = favoriteService.fetchFavorites()
        let ids = storedFavorites.map { $0.productId }
        favoriteProducts = allProducts.filter { ids.contains($0.id) }
    }
    
    func isFavorite(_ productID: Int) -> Bool {
        filteredProducts.contains { $0.id == productID }
    }
    
    func getProducts() async {
        isLoading = true
        
        do {
            products = try await productService.getProducts()
        }  catch {
            errorMessage = "Error to fetch products \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func getProduct(by id: Int) async {
        if products.isEmpty {
            await getProducts()
        }
        
        if let product = products.first(where: { $0.id == id }) {
            self.product = product
        }
    }
    
    func addToFavorite(product: Product) {
        favoriteService.add(product.id)
    }
    
    func removeFromFavorite(product: Product) {
        favoriteService.remove(product.id)
    }
}
