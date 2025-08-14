//
//  Order.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation
import SwiftData

@Model
class Order: Identifiable {
    var id = UUID()
    var products: [Product] = []
    
    init(id: UUID = UUID(), products: [Product]) {
        self.id = id
        self.products = products
    }
}
