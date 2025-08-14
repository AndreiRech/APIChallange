//
//  TabBar.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    ContentView(viewmodel: ProductViewModel(service: ProductService()))
                }
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    Categories(viewModel: ProductViewModel(service: ProductService()))
                }
            }
            
            Tab("Cart", systemImage: "cart.fill") {
                NavigationStack {
                    ContentView(viewmodel: ProductViewModel(service: ProductService()))
                }
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                NavigationStack {
                    ContentView(viewmodel: ProductViewModel(service: ProductService()))
                }
            }
            
            Tab("Orders", systemImage: "bag.fill") {
                NavigationStack {
                    ContentView(viewmodel: ProductViewModel(service: ProductService()))
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
