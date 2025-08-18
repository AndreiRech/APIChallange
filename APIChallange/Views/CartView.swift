//
//  CartView.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import SwiftUI

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel(database: .shared)
    
    var body: some View {
        NavigationStack {
            if cartViewModel.cartProducts.isEmpty {
                EmptyState(image: "cart.fill", title: "Carrinho Vazio", description: "Adicione produtos ao seu carrinho")
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(cartViewModel.cartProducts, id: \.self) { product in
                            ProductsList(
                                hasPicker: true,
                                product: product,
                                onQuantityChange: { quantity in
                                    print("Quantity changed to \(quantity) for product: \(product.title)")
                                }
                            )
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                cartViewModel.removeProduct(cartViewModel.cartProducts[index])
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Cart")
        .onAppear {
            cartViewModel.loadCartProducts()
        }
    }
}

#Preview {
    CartView()
}
