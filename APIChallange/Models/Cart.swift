//
//  Cart.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation
import SwiftData

@Model
final class Cart: Identifiable {
    var id = UUID()
    var productId: Int
    var quantity: Int
    
    init(id: UUID = UUID(), productId: Int, quantity: Int) {
        self.id = id
        self.productId = productId
        self.quantity = quantity
    }
}
