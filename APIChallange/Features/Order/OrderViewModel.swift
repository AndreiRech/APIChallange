//
//  OrderViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 19/08/25.
//

import Foundation

@Observable
class OrderViewModel: OrderViewModelProtocol, ObservableObject {
    private var orderService: OrderServiceProtocol
    private var productService: ProductsServiceProtocol
    
    var orderProducts: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var product: Product?
    var products: [Product] = []
        
    init(orderService: OrderServiceProtocol, productService: ProductsServiceProtocol) {
        self.orderService = orderService
        self.productService = productService
    }
    
    func loadOrderProducts(allProducts: [Product]) {
        let storedOrder = orderService.fetchOrders()
        let ids = storedOrder.map { $0.productId }
        orderProducts = allProducts.filter { ids.contains($0.id) }
    }
    
    var searchText: String = ""

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return orderProducts
        } else {
            return orderProducts.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
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
