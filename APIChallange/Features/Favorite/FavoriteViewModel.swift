//
//  FavoriteViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//
import Foundation

@Observable
class FavoriteViewModel: FavoriteViewModelProtocol, ObservableObject {
    var favoriteProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let database: SwiftDataService
    
    init(database: SwiftDataService) {
        self.database = database
    }
    
    func loadFavoriteProducts(allProducts: [Product]) {
        let storedFavorites = database.fetchFavoriteProducts()
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
}
