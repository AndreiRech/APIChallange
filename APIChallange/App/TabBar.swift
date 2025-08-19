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
                Home(viewmodel: ProductViewModel(service: ProductService(), database: .shared))
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    Categories(viewModel: CategoryViewModel())
                }
            }
            
            Tab("Cart", systemImage: "cart.fill") {
                CartView(productViewModel: ProductViewModel(service: ProductService(), database: .shared))
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                FavoriteView(productViewModel: ProductViewModel(service: ProductService(), database: .shared))
            }
            
            Tab("Orders", systemImage: "bag.fill") {
                OrderView(productViewModel: ProductViewModel(service: ProductService(), database: .shared))
            }
        }
    }
}

#Preview {
    TabBar()
}
