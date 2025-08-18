//
//  Favorite.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//

import Foundation
import SwiftData

@Model
final class Favorite: Identifiable {
    var id = UUID()
    var productId: Int
    
    init(id: UUID = UUID(), productId: Int) {
        self.id = id
        self.productId = productId
    }
}
