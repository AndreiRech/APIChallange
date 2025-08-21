//
//  ProductCardLarge.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    @State var isFavorite: Bool
    var product: Product
    var onToggleFavorite: ((Product, Bool) -> Void)?
    
    var body: some View {
        HStack(spacing: 16) {
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
   
            VStack {
                HStack {
                    Text(product.category.uppercased())
                        .font(.footnote)
                        .foregroundStyle(Color(.secondaryLabel))
                    
                    Spacer()
                    
                    Button {
                        isFavorite.toggle()
                        onToggleFavorite?(product, isFavorite)
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
                }

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
                .padding(.top, 24)
            }
        }
        .padding(8)
        .frame(height: 176)
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

//#Preview {
//    ProductCardLarge()
//}
