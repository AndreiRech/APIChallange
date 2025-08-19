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
            for: Favorite.self, Cart.self, Order.self,
//            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchFavoriteProducts() -> [Favorite] {
        do {
            return try modelContext.fetch(FetchDescriptor<Favorite>())
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
    
    func addToFavorite(_ productId: Int) {
        modelContext.insert(Favorite(productId: productId))
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addToCart(_ productId: Int, _ quantity: Int) {
        modelContext.insert(Cart(productId: productId, quantity: quantity))
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addToOrder(_ productId: Int) {
        modelContext.insert(Order(productId: productId))
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
