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
    var totalSum: Double = 0.0
    
    private let database: SwiftDataServiceProtocol
    
    init(database: SwiftDataServiceProtocol) {
        self.database = database
    }
    
    func loadCartProducts(allProducts: [Product]) {
        let storedCart = database.fetchCartProducts()
        let ids = storedCart.map { $0.productId }
        cartProducts = allProducts.filter { ids.contains($0.id) }
        
        if totalSum == 0.0 {
            calculateTotalSum()
        }
    }
    
    func removeProduct(_ productId: Int) {
        database.removeCartProduct(productId)
        calculateTotalSum()
    }
    
    func updateProductQuantity(_ productId: Int, quantity: Int) {
        database.editQuantityProduct(productId, quantity)
        calculateTotalSum()
    }
    
    func calculateTotalSum() {
        var aux = 0.0
        cartProducts.forEach { product in
            aux += product.price * Double(getQuantity(by: product.id))
        }
        totalSum = aux
    }
    
    func getQuantity(by id: Int) -> Int {
        let carts = database.fetchCartProducts()
        return carts.first(where: { $0.productId == id })?.quantity ?? 1
    }
    
    func clearCart() {
        for product in cartProducts {
            database.addToOrder(product.id)
            database.removeCartProduct(product.id)
        }
        cartProducts.removeAll()
        calculateTotalSum()
    }
}
