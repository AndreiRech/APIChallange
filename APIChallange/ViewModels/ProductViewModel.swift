//
//  ProductViewModel.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation

@Observable
class ProductViewModel: ProductViewModelProtocol {
    var product: Product?

    var products: [Product] = []

    var isLoading: Bool = false

    var errorMessage: String?
    
    private let service: ProductsServiceProtocol

        
    init(service: ProductsServiceProtocol) {
        self.service = service
    }
    
    
    func getProducts() async {
        isLoading = true
        
        do {
            products = try await service.getProducts()
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
