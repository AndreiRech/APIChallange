//
//  FavoriteView.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel(database: .shared)
    var productViewModel: ProductViewModelProtocol
    @State var selectedProduct: Product?
    
    var body: some View {
        NavigationStack {
            if viewModel.favoriteProducts.isEmpty {
                EmptyState(
                    image: "heart.slash",
                    title: String(localized: "No favorites yet!"),
                    description: String(localized: "Favorite an item and it will show up here.")
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredProducts, id: \.self) { product in
                            ProductsList(
                                hasPicker: false,
                                product: product,
                                quantity: 0,
                                onAddToCart: {
                                    selectedProduct = product
                                }
                            )
                        }
                    }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search")
                .navigationTitle("Favorites")
            }
        }
        .task {
            await productViewModel.getProducts()
            viewModel.loadFavoriteProducts(allProducts: productViewModel.products)
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetails(viewModel: ProductViewModel(service: ProductService(), database: .shared), productID: product.id, isFavorite: viewModel.isFavorite(product.id))
                .presentationDragIndicator(.visible)
        }
    }
}
