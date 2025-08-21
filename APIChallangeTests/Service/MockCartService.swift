import Foundation
@testable import APIChallange

class MockCartService: CartServiceProtocol {
    var carts: [Cart] = []
    private var cart: Cart
    
    init() {
        self.cart = Cart(productId: 1, quantity: 1)
    }
    
    func fetchCart() -> [Cart] {
        carts
    }
    
    func add(_ productId: Int, _ quantity: Int) {
        carts.append(Cart(productId: productId, quantity: quantity))
    }
    
    func remove(_ productId: Int) {
        if let index = carts.firstIndex(where: { $0.productId == productId }) {
            carts.remove(at: index)
        }
    }
    
    func editQuantity(_ productId: Int, _ newQuantity: Int) {
        if let index = carts.firstIndex(where: { $0.productId == productId }) {
            carts[index].quantity = newQuantity
        }
    }
    
    func getQuantity(_ productId: Int) -> Int {
        if let index = carts.firstIndex(of: Cart(productId: productId, quantity: 1)) {
            return carts[index].quantity
        }
        return 0
    }
    
    func clear() {
        carts.removeAll()
    }
        
}

