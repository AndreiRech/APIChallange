//
//  CategoryProducts.swift
//  APIChallange
//
//  Created by Andrei Rech on 15/08/25.
//

import SwiftUI

struct CategoryProducts: View {
    @State var viewModel: CategoryProductsViewModelProtocol
    @State var selectedProduct: Product?
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.filteredProducts) { product in
                            ProductCard(isFavorite: viewModel.isFavorite(product.id), product: product) { product, isFav in
                                if isFav {
                                    viewModel.addToFavorite(product: product)
                                } else {
                                    viewModel.removeFromFavorite(product: product)
                                }
                            }
                                .onTapGesture {
                                    selectedProduct = product
                                }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
                .searchable(text: $viewModel.searchText, prompt: "Search")
                .refreshable {
                    await viewModel.getProducts()
                }
            }
        }
        .navigationTitle(viewModel.category.stringLocalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.getProducts()
            viewModel.loadFavoriteProducts(allProducts: viewModel.filteredProducts)
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetails(viewModel: ProductViewModel(productService: ProductService(), favoriteService: FavoriteService(), cartService: CartService(), orderService: OrderService()), productID: product.id, isFavorite: viewModel.isFavorite(product.id))
                .presentationDragIndicator(.visible)
        }
    }
}

