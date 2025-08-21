//
//  ProductViewModel.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation

@Observable
class ProductViewModel: ProductViewModelProtocol, ObservableObject {
    var product: Product?
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let productService: ProductsServiceProtocol
    private let favoriteService: FavoriteServiceProtocol
    private let cartService: CartServiceProtocol
    private let orderService: OrderServiceProtocol
   
    init(productService: ProductsServiceProtocol, favoriteService: FavoriteServiceProtocol, cartService: CartServiceProtocol, orderService: OrderServiceProtocol) {
        self.productService = productService
        self.favoriteService = favoriteService
        self.cartService = cartService
        self.orderService = orderService
    }
    
    func getProducts() async {
        isLoading = true
        
        do {
            products = try await productService.getProducts()
        }  catch {
            errorMessage = "Error to fetch products \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func getProduct(by id: Int) async {
        if products.isEmpty {
            await getProducts()
        }
        
        if let product = products.first(where: { $0.id == id }) {
            self.product = product
        }
    }
    
    func addToFavorite(product: Product) {
        favoriteService.add(product.id)
    }
    
    func removeFromFavorite(product: Product) {
        favoriteService.remove(product.id)
    }
    
    func addToCart(product: Product) {
        cartService.add(product.id, 1)
    }
    
    func addToOrder(product: Product) {
        orderService.add(product.id)
    }
}
