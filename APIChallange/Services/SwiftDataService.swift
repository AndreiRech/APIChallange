//
//  SwiftDataService.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import SwiftUI
import SwiftData

class SwiftDataService {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    init() {
        self.modelContainer = try! ModelContainer(
            for: StoredProduct.self, Favorite.self, Cart.self, Order.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchProducts() -> [StoredProduct] {
        do {
            return try modelContext.fetch(FetchDescriptor<StoredProduct>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchFavoriteProducts() -> [StoredProduct] {
        do {
            let products = fetchProducts()
            let favorites = try modelContext.fetch(FetchDescriptor<Favorite>())
            
            let finalProducts = products.filter { product in
                favorites.contains { $0.productId == product.id }
            }
                    
            return finalProducts
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchCartProducts() -> [Cart] {
        do {
            return try modelContext.fetch(FetchDescriptor<Cart>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchOrderProducts() -> [Order] {
        do {
            return try modelContext.fetch(FetchDescriptor<Order>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addProduct(_ product: StoredProduct) {
        modelContext.insert(product)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeProduct(_ product: StoredProduct) {
        modelContext.delete(product)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addToFavorite(_ id: Int) {
        modelContext.insert(Favorite(productId: id))
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
