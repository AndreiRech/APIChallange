//
//  StoredProducts.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import SwiftUI
import SwiftData

@Model
class StoredProduct {
    var id: Int
    var title: String
    var details: String
    var category: String
    var price: Double
    var shippingInformation: String
    var thumbnail: String
    var isFavorite: Bool
    var isOnCart: Bool
    var isOrdered: Bool
    
    init(
        id: Int,
        title: String,
        details: String,
        category: String,
        price: Double,
        shippingInformation: String,
        thumbnail: String,
        isFavorite: Bool,
        isOnCart: Bool,
        isOrdered: Bool
    ) {
        self.id = id
        self.title = title
        self.details = details
        self.category = category
        self.price = price
        self.shippingInformation = shippingInformation
        self.thumbnail = thumbnail
        self.isFavorite = isFavorite
        self.isOnCart = isOnCart
        self.isOrdered = isOrdered
    }
}
