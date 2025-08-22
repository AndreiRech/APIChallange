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
                Home(viewModel: HomeViewModel(favoriteService: FavoriteService(), productService: ProductService()))
            }
            
            Tab("Categories", systemImage: "square.grid.2x2.fill") {
                NavigationStack {
                    Categories(viewModel: CategoryViewModel())
                }
            }
            
            Tab("Cart", systemImage: "cart.fill") {
                CartView(viewModel: CartViewModel(cartService: CartService(), orderService: OrderService(), productService: ProductService()))
            }
            
            Tab("Favorites", systemImage: "heart.fill") {
                FavoriteView(viewModel: FavoriteViewModel(favoriteService: FavoriteService(), productService: ProductService()))
            }
            
            Tab("Orders", systemImage: "bag.fill") {
                OrderView(viewModel: OrderViewModel(orderService: OrderService(), productService: ProductService()))
            }
        }
    }
}

#Preview {
    TabBar()
}
