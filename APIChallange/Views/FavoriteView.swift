//
//  FavoriteView.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel(database: .shared)
    
    var body: some View {
        VStack {
            if viewModel.favoriteProducts.isEmpty {
                EmptyState(
                    image: "heart.fill",
                    title: "Favoritos",
                    description: "Seus produtos favoritos aparecerão aqui"
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.favoriteProducts, id: \.self) { product in
                            ProductsList(
                                hasPicker: false,
                                product: product,
                                onQuantityChange: { quantity in
                                    print("Quantity changed to \(quantity) for product: \(product.title)")
                                }
                            )
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.loadFavoriteProducts()
        }
    }
}
