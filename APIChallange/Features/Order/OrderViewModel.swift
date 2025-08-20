//
//  OrderViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 19/08/25.
//

import Foundation

@Observable
class OrderViewModel: OrderViewModelProtocol, ObservableObject {
    var orderProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let database: SwiftDataServiceProtocol
    
    init(database: SwiftDataServiceProtocol) {
        self.database = database
    }
    
    func loadOrderProducts(allProducts: [Product]) {
        let storedOrder = database.fetchOrderProducts()
        let ids = storedOrder.map { $0.productId }
        orderProducts = allProducts.filter { ids.contains($0.id) }
    }
    
    var searchText: String = ""

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return orderProducts
        } else {
            return orderProducts.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}
