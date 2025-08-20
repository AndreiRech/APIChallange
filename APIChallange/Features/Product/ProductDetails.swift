//
//  ProductDetails.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import SwiftUI

struct ProductDetails: View {
    @Environment(\.dismiss) var dismiss
    var viewModel: ProductViewModelProtocol
    let productID: Int
    @State var isFavorite: Bool

    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack {
                    if let product = viewModel.product {
                        ScrollView {
                            VStack (alignment: .leading, spacing: 16) {
                                AsyncImage(url: URL(string: product.thumbnail)) { image in
                                    image.resizable()
                                        .scaledToFit()
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .foregroundStyle(Color(.tertiarySystemFill))
                                        )
                                } placeholder: {
                                    DefaultImage(imageName: "bag.fill", large: true)
                                }
                                .frame(width: 361, height: 361)
                                .overlay(
                                    Button {
                                        if isFavorite {
                                            viewModel.removeFromFavorite(product: product)
                                        } else {
                                            viewModel.addToFavorite(product: product)
                                        }
                                        isFavorite.toggle()
                                    } label: {
                                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                                            .resizable()
                                            .foregroundStyle(Color(.label))
                                    }
                                    .padding(8)
                                    .frame(width: 38, height: 38)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .foregroundStyle(Color(.tertiarySystemFill))
                                    ),
                                    alignment: .topTrailing
                                )
                                .cornerRadius(8)

                                VStack (alignment: .leading, spacing: 4) {
                                    Text(product.title)
                                        .font(.system(.title3, weight: .regular))
                                        .foregroundStyle(Color(.label))
                                    
                                    Text("US$ \(product.price.description)")
                                        .font(.system(.title2, weight: .bold))
                                        .foregroundStyle(Color(.label))
                                }

                                Text(product.description)
                                    .font(.system(.body, weight: .regular))
                                    .foregroundStyle(Color(.secondaryLabel))
                            }
                        }

                        Button {
                            viewModel.addToCart(product: product)
                            dismiss()
                        } label: {
                            Text("Add to Cart")
                                .font(.system(.body, weight: .semibold))
                                .foregroundStyle(Color(.label))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(Color(.tertiarySystemFill))
                        )
                    }
                }
                .padding()
                .navigationTitle("Details")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar(.visible, for: .navigationBar)
                .toolbarBackground(Color(.tertiarySystemBackground), for: .navigationBar)
            }
        }
        .task {
            await viewModel.getProduct(by: productID)
        }
    }
}

//#Preview {
//    ProductDetails()
//}
