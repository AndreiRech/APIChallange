//
//  APIChallangeApp.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI
import SwiftData

@main
struct APIChallangeApp: App {
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(for: [Cart.self, Order.self, Favorite.self])
    }
}
