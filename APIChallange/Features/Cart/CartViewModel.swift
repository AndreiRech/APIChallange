//
//  CartViewModel.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import Foundation

@Observable
class CartViewModel: CartViewModelProtocol, ObservableObject {
    var cartProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let database: SwiftDataService
    
    init(database: SwiftDataService) {
        self.database = database
    }
    
    func loadCartProducts(allProducts: [Product]) {
        let storedCart = database.fetchCartProducts()
        let ids = storedCart.map { $0.productId }
        cartProducts = allProducts.filter { ids.contains($0.id) }
    }
    
    func removeProduct(_ productId: Int) {
        // TODO: implementar
    }
    
    func updateProductQuantity(_ productId: Int, quantity: Int) {
        // TODO: implementar a quantidade
    }
}
