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
            if viewModel.productViewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.filteredProducts) { product in
                            ProductCard(isFavorite: false, product: product)
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
            await viewModel.loadProducts()
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetails(viewModel: ProductViewModel(service: ProductService(), database: .shared), productID: product.id)
                .presentationDragIndicator(.visible)
        }
    }
}

