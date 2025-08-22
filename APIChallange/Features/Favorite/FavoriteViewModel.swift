//
//  FavoriteViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//
import Foundation

@Observable
class FavoriteViewModel: FavoriteViewModelProtocol, ObservableObject {
    private let favoriteService: FavoriteServiceProtocol
    private let productService: ProductsServiceProtocol
    
    var favoriteProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var product: Product?
    var products: [Product] = []
        
    init(favoriteService: FavoriteServiceProtocol, productService: ProductsServiceProtocol) {
        self.favoriteService = favoriteService
        self.productService = productService
    }
    
    func loadFavoriteProducts(allProducts: [Product]) {
        let storedFavorites = favoriteService.fetchFavorites()
        let ids = storedFavorites.map { $0.productId }
        favoriteProducts = allProducts.filter { ids.contains($0.id) }
    }
    
    var searchText: String = ""
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return favoriteProducts
        } else {
            return favoriteProducts.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
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
}
