//
//  CartViewModel.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import Foundation

@Observable
class CartViewModel: CartViewModelProtocol, ObservableObject {
    private let cartService: CartServiceProtocol
    private let orderService: OrderServiceProtocol
    private let productService: ProductsServiceProtocol
    
    var cartProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var totalSum: Double = 0.0
    var product: Product?
    var products: [Product] = []
    
    init(cartService: CartServiceProtocol, orderService: OrderServiceProtocol, productService: ProductsServiceProtocol) {
        self.cartService = cartService
        self.orderService = orderService
        self.productService = productService
    }
    
    func loadCartProducts(allProducts: [Product]) {
        let storedCart = cartService.fetchCart()
        let ids = storedCart.map { $0.productId }
        cartProducts = allProducts.filter { ids.contains($0.id) }
        
        if totalSum == 0.0 {
            calculateTotalSum()
        }
    }
    
    func removeProduct(_ productId: Int) {
        cartService.remove(productId)
        loadCartProducts(allProducts: products)
        calculateTotalSum()
    }
    
    func updateProductQuantity(_ productId: Int, quantity: Int) {
        cartService.editQuantity(productId, quantity)
        loadCartProducts(allProducts: products)
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
        let carts = cartService.fetchCart()
        return carts.first(where: { $0.productId == id })?.quantity ?? 0
    }
    
    func clearCart() {
        for product in cartProducts {
            orderService.add(product.id)
            cartService.remove(product.id)
        }
        cartProducts.removeAll()
        calculateTotalSum()
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
}
