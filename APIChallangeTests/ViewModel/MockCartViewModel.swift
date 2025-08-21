//
//  MockCartViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 21/08/25.
//

import Foundation
@testable import APIChallange

class MockCartViewModel: CartViewModelProtocol {
    var cartProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var totalSum: Double = 0.0
    var product: Product?
    var products: [Product] = []
    
    private let cartService = MockCartService()
    private let orderService = MockOrderService()
    private let productService = MockProductService()
    
    // Variaveis suportes
    var shouldFail: Bool = false
    var getProductsCalled: Bool = false
    var loadCartCalled: Bool = false
    var removeProductCalled: Bool = false
    var updateProductCalled: Bool = false
    var getQuantityCalled: Bool = false
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }
    
    func loadCartProducts(allProducts: [Product]) {
        loadCartCalled = true
        
        if totalSum == 0 {
            calculateTotalSum()
        }
    }
    
    func removeProduct(_ productId: Int) {
        removeProductCalled = true
        
        cartService.remove(productId)
    }
    
    func updateProductQuantity(_ productId: Int, quantity: Int) {
        updateProductCalled = true
        
        cartService.editQuantity(productId, quantity)
    }
    
    func getQuantity(by id: Int) -> Int {
        getProductsCalled = true
        
        return cartService.getQuantity(id)
    }
    
    func clearCart() {
        
        cartService.clear()
    }
    
    func calculateTotalSum() {
        totalSum = 1
    }
    
    func getProducts() async {
        getProductsCalled = true
        
        if shouldFail {
            products = []
            errorMessage = "Error"
        } else {
            products = [
                Product(id: 1, title: "title", description: "description", category: "Beauty", price: 10.5,             shippingInformation: "Tomorrow", thumbnail: "image"),
                Product(id: 2, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
            ]
        }
        
    }
    
    func getProduct(by id: Int) async {
        getProductsCalled = true
        
        if let product = products.first(where: { $0.id == id }) {
            self.product = product
        }
    }
}
