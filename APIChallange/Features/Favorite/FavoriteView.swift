//
//  FavoriteView.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//

import SwiftUI

struct FavoriteView: View {
    @State var viewModel: FavoriteViewModelProtocol
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
            await viewModel.getProducts()
            viewModel.loadFavoriteProducts(allProducts: viewModel.products)
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetails(viewModel: ProductViewModel(productService: ProductService(), favoriteService: FavoriteService(), cartService: CartService(), orderService: OrderService()), productID: product.id, isFavorite: viewModel.isFavorite(product.id))
                .presentationDragIndicator(.visible)
        }
    }
}
