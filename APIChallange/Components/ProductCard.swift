//
//  ProductCard.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct ProductCard: View {
    let productViewModel: ProductViewModel = .init(service: ProductService(), database: .shared)
    @State var isFavorite: Bool
    var product: Product
    
    var body: some View {
        VStack(spacing: 8) {
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
            .frame(width: 160, height: 160)
            .overlay(
                Button {
                    if isFavorite {
                        productViewModel.removeFromFavorite(product: product)
                    } else {
                        productViewModel.addToFavorite(product: product)
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
                    )
                    .accessibilityLabel(isFavorite ? "Remove from Favorites" : "Add to Favorites")
                    .accessibilityHint("Touch to toggle favorite status")
                , alignment: .topTrailing
            )
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                
                Text(product.price.formatted(
                    .currency(code: Locale.current.currency?.identifier ?? "USD")
                    .precision(.fractionLength(2))
                ))
                .font(.headline)
            }
            .frame(maxHeight: .infinity)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .frame(height: 250)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.secondarySystemBackground))
        )
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(product.title), price: \(product.price.formatted(.currency(code: "USD")))")
        .accessibilityHint("Touch to see the product details")
        .accessibilityAddTraits(.isButton)
    }
}
