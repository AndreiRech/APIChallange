//
//  CartView.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel(database: .shared)
    var productViewModel: ProductViewModelProtocol
    
    var body: some View {
        NavigationStack {
            if viewModel.cartProducts.isEmpty {
                EmptyState(
                    image: "cart.fill",
                    title: "Carrinho Vazio",
                    description: "Adicione produtos ao seu carrinho"
                )
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.cartProducts, id: \.self) { product in
                            ProductsList(
                                hasPicker: true,
                                product: product,
                                onQuantityChange: { quantity in
                                }
                            )
                        }
//                        .onDelete { indexSet in
//                            for index in indexSet {
//                                viewModel.removeProduct(viewModel.cartProducts[index])
//                            }
//                        }
                    }
                }
                .navigationTitle("Cart")
            }
        }
        .task {
            await productViewModel.getProducts()
            viewModel.loadCartProducts(allProducts: productViewModel.products)
        }
    }
}
