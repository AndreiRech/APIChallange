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
    var productId: Int
    
    init(id: UUID = UUID(), productId: Int) {
        self.id = id
        self.productId = productId
    }
}
