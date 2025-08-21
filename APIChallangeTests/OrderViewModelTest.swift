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
}
