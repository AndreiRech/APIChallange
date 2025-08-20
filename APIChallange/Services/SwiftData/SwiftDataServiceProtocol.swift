protocol SwiftDataServiceProtocol {
    func fetchFavoriteProducts() -> [Favorite]
    func fetchCartProducts() -> [Cart]
    func fetchOrderProducts() -> [Order]
    func addToFavorite(_ productId: Int)
    func addToCart(_ productId: Int, _ quantity: Int)
    func addToOrder(_ productId: Int)
    func removeCartProduct(_ productId: Int)
    func removeFavoriteProduct(_ productId: Int)
    func editQuantityProduct(_ productId: Int, _ newQuantity: Int)
}
