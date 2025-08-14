//
//  ProductService.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation

class ProductService: ProductsServiceProtocol {
    private let baseURL = "https://dummyjson.com/products"
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(ProductResponse.self, from: data)
        
        return products.products
    }
}
