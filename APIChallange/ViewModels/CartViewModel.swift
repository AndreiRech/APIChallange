//
//  CartViewModel.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import Foundation

@Observable
class CartViewModel: CartViewModelProtocol, ObservableObject {
    var cartProducts: [Cart] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let database: SwiftDataService
    
    init(database: SwiftDataService) {
        self.database = database
    }
    
    func loadCartProducts() {
        isLoading = true
        cartProducts = database.fetchCartProducts()
        isLoading = false
    }
    
    func removeProduct(_ product: StoredProduct) {
        database.removeProduct(product)
        loadCartProducts()
    }
    
    func updateProductQuantity(_ product: StoredProduct, quantity: Int) {
        // TODO: implementar a quantidade
    }
}
