//
//  Order.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation
import SwiftData

@Model
final class Order: Identifiable {
    var id = UUID()
    var products: [StoredProduct] = []
    
    init(id: UUID = UUID(), products: [StoredProduct]) {
        self.id = id
        self.products = products
    }
}
