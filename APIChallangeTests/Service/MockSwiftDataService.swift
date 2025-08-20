@testable import APIChallange

class MockSwiftDataService: SwiftDataServiceProtocol {
    var favorites: [Favorite] = []
    var cart: [Cart] = []
    var orders: [Order] = []
    
    func fetchFavoriteProducts() -> [Favorite] {
        favorites
    }
    
    func fetchCartProducts() -> [Cart] {
        cart
    }
    
    func fetchOrderProducts() -> [Order] {
        orders
    }
    
    func addToFavorite(_ productId: Int) {
        favorites.append(Favorite(productId: productId))
    }
    
    func addToCart(_ productId: Int, _ quantity: Int) {
        cart.append(Cart(productId: productId, quantity: quantity))
    }
    
    func addToOrder(_ productId: Int) {
        orders.append(Order(productId: productId))
    }
    
    func removeCartProduct(_ productId: Int) {
        cart.removeAll { $0.productId == productId }
    }
    
    func removeFavoriteProduct(_ productId: Int) {
        favorites.removeAll { $0.productId == productId }
    }
    
    func editQuantityProduct(_ productId: Int, _ newQuantity: Int) {
        if let idx = cart.firstIndex(where: { $0.productId == productId }) {
            cart[idx].quantity = newQuantity
        }
    }
}
