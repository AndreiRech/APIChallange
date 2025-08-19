//
//  FavoriteView.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//

import SwiftUI

struct OrderView: View {
    @StateObject private var viewModel = OrderViewModel(database: .shared)
    var productViewModel: ProductViewModelProtocol
    
    var body: some View {
        NavigationStack {
            if viewModel.orderProducts.isEmpty {
                EmptyState(
                    image: "bag.fill",
                    title: "Orders",
                    description: "Seus produtos ordenados aparecerão aqui"
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.filteredProducts, id: \.self) { product in
                            OrderCard(
                                product: product
                            )
                        }
                    }
                }
                .padding()
                .searchable(text: $viewModel.searchText, prompt: "Search")
                .navigationTitle("Orders")
            }
        }
        .task {
            await productViewModel.getProducts()
            viewModel.loadOrderProducts(allProducts: productViewModel.products)
        }
    }
}
