//
//  APIChallangeTests.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 20/08/25.
//

import Foundation
@testable import APIChallange

class MockProductService: ProductsServiceProtocol {
    var shouldFail: Bool
    private var products: [Product]

    init(shouldFail: Bool = false, products: [Product] = [
        Product(id: 1, title: "title", description: "description", category: "Beauty", price: 10.5, shippingInformation: "Tomorrow", thumbnail: "image")
    ]) {
        self.shouldFail = shouldFail
        self.products = products
    }

    func getProducts() async throws -> [Product] {
        if shouldFail {
            throw NSError(domain: #function, code: 1)
        } else {
            return products
        }
    }
}
