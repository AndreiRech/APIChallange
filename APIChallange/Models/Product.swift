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
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case category
        case price
        case shippingInformation
        case thumbnail
    }
}

struct ProductResponse: Decodable {
    var products: [Product]
}
