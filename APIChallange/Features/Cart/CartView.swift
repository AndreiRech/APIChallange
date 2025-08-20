//
//  CartView.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import SwiftUI

struct CartView: View {
    @StateObject var viewModel = CartViewModel(database: .shared)
    var productViewModel: ProductViewModelProtocol
    @State var changed: Bool = false
    
    var body: some View {
        NavigationStack {
            if viewModel.cartProducts.isEmpty {
                EmptyState(
                    image: "cart.badge.questionmark",
                    title: String(localized: "Your cart is empty!"),
                    description: String(localized: "Add an item to your cart.")
                )
            } else {
                VStack {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.cartProducts, id: \.self) { product in
                                ProductsList(
                                    hasPicker: true,
                                    product: product,
                                    quantity: viewModel.getQuantity(by: product.id),
                                    onQuantityChange: { quantity in
                                        if quantity == 0 {
                                            viewModel.removeProduct(product.id)
                                            changed = true
                                        } else {
                                            viewModel.updateProductQuantity(product.id, quantity: quantity)
                                        }
                                    }
                                )
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Total:")
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text(viewModel.totalSum.formatted(
                                .currency(code: Locale.current.currency?.identifier ?? "USD")
                                .precision(.fractionLength(2))
                            ))
                            .font(.headline)
                        }
                        
                        Button {
                            viewModel.clearCart()
                        } label: {
                            Text("Checkout")
                                .fontWeight(.bold)
                                .foregroundStyle(Color(.label))
                                .padding(.vertical, 16)
                        }
                        .frame(height: 54)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(Color(.tertiarySystemFill))
                        )
                    }
                }
                .padding()
                .navigationTitle("Cart")
            }
        }
        .task {
            await productViewModel.getProducts()
            viewModel.loadCartProducts(allProducts: productViewModel.products)
        }
        .onChange(of: changed) { _, _ in
            viewModel.loadCartProducts(allProducts: productViewModel.products)
            viewModel.calculateTotalSum()
            changed = false
        }
    }
}
