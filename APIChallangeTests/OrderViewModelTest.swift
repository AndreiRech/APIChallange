//
//  OrderViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 21/08/25.
//

import Foundation
import Testing
@testable import APIChallange

struct OrderViewModelTest {
    @Test func fetchOrders() async throws {
        // Given
        let mockOrderService = MockOrderService()
        let mockProductService = MockProductService()
        let viewModel = OrderViewModel(orderService: mockOrderService, productService: mockProductService)
        
        // When
        let products = try await mockProductService.getProducts()
        viewModel.loadOrderProducts(allProducts: products)
        
        // Then
        #expect(!viewModel.orderProducts.isEmpty)
    }
    
    @Test func fetchOrdersShouldFail() async throws {
        // Given
        let mockOrderService = MockOrderService()
        let mockProductService = MockProductService(shouldFail: true)
        let viewModel = OrderViewModel(orderService: mockOrderService, productService: mockProductService)
        
        // When
        await viewModel.getProducts()
        
        // Then
        #expect(viewModel.orderProducts.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
    
    @Test func getAllOrderProducts() async throws {
        let mockOrderService = MockOrderService()
        let mockProductService = MockProductService()
        
        let allProducts: [Product] = [
            Product(id: 1, title: "A", description: "", category: "", price: 10, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "B", description: "", category: "", price: 20, shippingInformation: "", thumbnail: ""),
            Product(id: 99, title: "C", description: "", category: "", price: 30, shippingInformation: "", thumbnail: "")
        ]
        
        let viewModel = OrderViewModel(orderService: mockOrderService, productService: mockProductService)

        #expect(viewModel.orderProducts.isEmpty)
        
        mockOrderService.add(1)
        mockOrderService.add(2)

        await viewModel.getProducts()
        viewModel.loadOrderProducts(allProducts: allProducts)

        #expect(viewModel.orderProducts.count == 2)
    }
    
    @Test func getFavoriteProduct() async throws {
        // Given
        let mockOrderService = MockOrderService()
        let mockProductService = MockProductService()
        
        let allProducts: [Product] = [
            Product(id: 1, title: "A", description: "", category: "", price: 10, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "B", description: "", category: "", price: 20, shippingInformation: "", thumbnail: ""),
            Product(id: 99, title: "C", description: "", category: "", price: 30, shippingInformation: "", thumbnail: "")
        ]

        mockOrderService.add(allProducts[0].id)

        let viewModel = OrderViewModel(orderService: mockOrderService, productService: mockProductService)

        #expect(viewModel.orderProducts.isEmpty)

        // When
        await viewModel.getProducts()
        viewModel.loadOrderProducts(allProducts: viewModel.products)
        await viewModel.getProduct(by: 1)

        // Then
        #expect(viewModel.orderProducts.count == 1)
        #expect(viewModel.orderProducts.first?.id == 1)
        #expect(viewModel.product?.id == 1)
    }
    
    @Test func getProductWhenProductsEmpty() async throws {
        let mockProductService = MockProductService()
        let mockOrderService = MockOrderService()
        let viewModel = OrderViewModel(orderService: mockOrderService, productService: mockProductService)

        #expect(viewModel.products.isEmpty)

        await viewModel.getProduct(by: 1)

        #expect(viewModel.product?.id == 1)
    }
    
    @Test func filteredProducts_searchText() async throws {
        let mockProductService = MockProductService()
        let mockOrderService = MockOrderService()
        let viewModel = OrderViewModel(orderService: mockOrderService, productService: mockProductService)
        
        let products = [
            Product(id: 1, title: "Apple", description: "", category: "", price: 1, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "Banana", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        ]
        mockOrderService.add(1)
        mockOrderService.add(2)
        
        viewModel.loadOrderProducts(allProducts: products)
        viewModel.searchText = "apple"
        
        #expect(viewModel.filteredProducts.count == 1)
        #expect(viewModel.filteredProducts[0].title == "Apple")
    }
    
    @Test func filteredProducts_emptySearchText() async throws {
        let mockProductService = MockProductService()
        let mockOrderService = MockOrderService()
        let viewModel = OrderViewModel(orderService: mockOrderService, productService: mockProductService)
        
        let products = [
            Product(id: 1, title: "Apple", description: "", category: "", price: 1, shippingInformation: "", thumbnail: ""),
            Product(id: 2, title: "Banana", description: "", category: "", price: 1, shippingInformation: "", thumbnail: "")
        ]
        mockOrderService.add(1)
        mockOrderService.add(2)
        
        viewModel.loadOrderProducts(allProducts: products)
        viewModel.searchText = ""
        
        #expect(viewModel.filteredProducts.count == 2)
        #expect(viewModel.filteredProducts[0].title == "Apple")
        #expect(viewModel.filteredProducts[1].title == "Banana")
    }
}
