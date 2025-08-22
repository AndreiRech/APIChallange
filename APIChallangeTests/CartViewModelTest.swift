//
//  CartViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 21/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct CartViewModelTests {
    @Test func fetchCarts() async throws {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService()
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProducts()
        await viewModel.getProduct(by: 1)
        
        viewModel.loadCartProducts(allProducts: viewModel.products)
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum > 0)
    }
    
    @Test func fetchOneProduct() async throws {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService()
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProduct(by: 1)
        
        viewModel.loadCartProducts(allProducts: viewModel.products)
        
        // Then
        #expect(!viewModel.products.isEmpty)
        #expect(viewModel.product != nil)
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum > 0)
    }
    
    @Test func fetchProductsShouldFail() async throws {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService(shouldFail: true)
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProducts()
        
        // Then
        #expect(viewModel.products.isEmpty)
        #expect(viewModel.product == nil)
        #expect(viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum == 0)
    }
    
    @Test func removeProductFromCart() async {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService()
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProducts()
        viewModel.loadCartProducts(allProducts: viewModel.products)
        
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum > 0)
        
        viewModel.removeProduct(1)
        
        // Then
        #expect(viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum == 0)
    }
    
    @Test func editProductFromCart() async {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService()
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProducts()
        viewModel.loadCartProducts(allProducts: viewModel.products)
        
        #expect(!viewModel.cartProducts.isEmpty)
        let totalSum = viewModel.totalSum
        #expect(totalSum > 0)
        
        viewModel.updateProductQuantity(1, quantity: 2)
        
        // Then
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum == totalSum * 2)
    }
    
    @Test func getQuantityById() async {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService()
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProducts()
        viewModel.loadCartProducts(allProducts: viewModel.products)
        
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum > 0)
        
        let quantity = viewModel.getQuantity(by: 1)
        
        // Then
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(quantity == 1)
    }
    
    @Test func getQuantityByIdShouldReturn0() async {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService()
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProducts()
        viewModel.loadCartProducts(allProducts: viewModel.products)
        
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum > 0)
        
        let quantity = viewModel.getQuantity(by: 3)
        
        // Then
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(quantity == 0)
    }
    
    @Test func clearCart() async {
        // Given
        let cartService = MockCartService()
        let orderService = MockOrderService()
        let productService = MockProductService()
        let viewModel = CartViewModel(cartService: cartService, orderService: orderService, productService: productService)
        
        // When
        await viewModel.getProducts()
        viewModel.loadCartProducts(allProducts: viewModel.products)
        
        #expect(!viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum > 0)
        
        viewModel.clearCart()
        
        // Then
        #expect(viewModel.cartProducts.isEmpty)
        #expect(viewModel.totalSum == 0)
    }
}
