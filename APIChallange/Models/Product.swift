//
//  Product.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation


struct Product: Decodable, Hashable, Identifiable, Encodable {
    var id: Int
    var title: String
    var description: String
    var category: String
    var price: Double
    var shippingInformation: String
    var thumbnail: String
}

struct ProductResponse: Decodable {
    var products: [Product]
}
