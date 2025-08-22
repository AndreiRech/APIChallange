//
//  FavoriteView.swift
//  APIChallange
//
//  Created by Andrei Rech on 18/08/25.
//

import SwiftUI

struct OrderView: View {
    @State var viewModel: OrderViewModelProtocol
    
    var body: some View {
        NavigationStack {
            if viewModel.orderProducts.isEmpty {
                EmptyState(
                    image: "bag.badge.questionmark",
                    title: String(localized: "No orders yet!"),
                    description: String(localized: "Buy an item and it will show up here.")
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
            await viewModel.getProducts()
            viewModel.loadOrderProducts(allProducts: viewModel.products)
        }
    }
}
