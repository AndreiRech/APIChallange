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
    
    init(
        id: Int,
        title: String,
        details: String,
        category: String,
        price: Double,
        shippingInformation: String,
        thumbnail: String,
    ) {
        self.id = id
        self.title = title
        self.details = details
        self.category = category
        self.price = price
        self.shippingInformation = shippingInformation
        self.thumbnail = thumbnail
    }
}
