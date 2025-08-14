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
    var products: [Product: Int]
    
    init(id: UUID = UUID(), products: [Product : Int]) {
        self.id = id
        self.products = products
    }
}
