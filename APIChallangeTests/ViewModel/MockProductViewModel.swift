import Foundation
@testable import APIChallange

@Observable
class MockProductViewModel: ProductViewModelProtocol {
    var product: Product?
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    var getProductsCalled = false
    var addToFavoriteCalled = false
    var removeFromFavoriteCalled = false
    var addToCartCalled = false
    var addToOrderCalled = false
    
    init() {
        self.product = Product(id: 1, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
        self.products = [Product(id: 1, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"), Product(id: 2, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")]
    }
    
    func getProducts() async {
        getProductsCalled = true
        isLoading = true
        
        if errorMessage == nil {
            // O array de produtos já foi definido no init
        } else {
            // Simula um estado de erro
            self.products = []
        }
        
        isLoading = false
    }
    
    func getProduct(by id: Int) async {
        if let product = products.first(where: { $0.id == id }) {
            self.product = product
        }
    }
    
    func addToFavorite(product: Product) {
        addToFavoriteCalled = true
        print("Product \(product.id) added to favorites (mock).")
    }
    
    func removeFromFavorite(product: Product) {
        removeFromFavoriteCalled = true
        print("Product \(product.id) removed from favorites (mock).")
    }
    
    func addToCart(product: Product) {
        addToCartCalled = true
        print("Product \(product.id) added to cart (mock).")
    }
    
    func addToOrder(product: Product) {
        addToOrderCalled = true
        print("Product \(product.id) added to order (mock).")
    }
}
