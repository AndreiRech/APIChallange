import Foundation
@testable import APIChallange

class MockProductViewModel: ProductViewModelProtocol {
    var product: Product?
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    // Variaveis suportes
    var shouldFail: Bool = false
    var getProductsCalled = false
    var addToFavoriteCalled = false
    var removeFromFavoriteCalled = false
    var addToCartCalled = false
    var addToOrderCalled = false
    
    init(shouldFail: Bool = false) {
        self.product = Product(id: 1, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
        self.products = [Product(id: 1, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image"), Product(id: 2, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")]
        self.shouldFail = shouldFail
    }
    
    func getProducts() async {
        getProductsCalled = true
        
        if shouldFail {
            products = []
            errorMessage = "Error"
        }
        
    }
    
    func getProduct(by id: Int) async {
        getProductsCalled = true
        
        if let product = products.first(where: { $0.id == id }) {
            self.product = product
        }
    }
    
    func addToFavorite(product: Product) {
        addToFavoriteCalled = true
    }
    
    func removeFromFavorite(product: Product) {
        removeFromFavoriteCalled = true
    }
    
    func addToCart(product: Product) {
        addToCartCalled = true
    }
    
    func addToOrder(product: Product) {
        addToOrderCalled = true
    }
}
