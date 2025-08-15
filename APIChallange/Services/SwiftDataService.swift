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
        self.modelContainer = try! ModelContainer(for: StoredProduct.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchProducts() -> [StoredProduct] {
        do {
            return try modelContext.fetch(FetchDescriptor<StoredProduct>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchCartProducts() -> [StoredProduct] {
        do {
            let descriptor = FetchDescriptor<StoredProduct>(
                predicate: #Predicate<StoredProduct> { $0.isOnCart == true }
            )
            return try modelContext.fetch(descriptor)
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
}
