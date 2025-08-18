//
//  FavoriteViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//
import Foundation

@Observable
class FavoriteViewModel: FavoriteViewModelProtocol, ObservableObject {
    var favoriteProducts: [StoredProduct] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let database: SwiftDataService
    
    init(database: SwiftDataService) {
        self.database = database
    }
    
    func loadFavoriteProducts() {
        isLoading = true
        favoriteProducts = database.fetchFavoriteProducts()
        isLoading = false
    }
}
