//
//  APIChallangeTests.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 20/08/25.
//

import Foundation
@testable import APIChallange

class MockProductService: ProductsServiceProtocol {
    var shouldFail: Bool = false
    private var product: Product
    
    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
        self.product = Product(id: 1, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
    }

    func getProducts() async throws -> [Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return [product]
        }
    }
    
}
