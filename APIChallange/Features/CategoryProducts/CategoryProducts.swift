//
//  CategoryProducts.swift
//  APIChallange
//
//  Created by Andrei Rech on 15/08/25.
//

import SwiftUI

struct CategoryProducts: View {
    @State var viewModel: CategoryProductsViewModelProtocol
    let favoriteViewModel: FavoriteViewModel = .init(database: .shared)
    @State var selectedProduct: Product?
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            if viewModel.productViewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.filteredProducts) { product in
                            ProductCard(isFavorite: favoriteViewModel.isFavorite(product.id), product: product)
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
                    await viewModel.loadProducts()
                }
            }
        }
        .navigationTitle(viewModel.category.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            favoriteViewModel.loadFavoriteProducts(allProducts: viewModel.filteredProducts)
            await viewModel.loadProducts()
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetails(viewModel: ProductViewModel(service: ProductService(), database: .shared), productID: product.id, isFavorite: favoriteViewModel.isFavorite(product.id))
                .presentationDragIndicator(.visible)
        }
    }
}

