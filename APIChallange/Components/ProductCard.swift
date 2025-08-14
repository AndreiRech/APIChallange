//
//  ProductCard.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct ProductCard: View {
    @State var isFavorite: Bool = false
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
                DefaultImage(imageName: "bag.fill")
            }
            .frame(width: 160, height: 160)
            .overlay(
                Button {
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
                , alignment: .topTrailing
            )
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)
                
                Text(product.price.description)
                    .font(.headline)
            }
        }
        .padding(8)
        .frame(width: 177, height: 250)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.secondarySystemBackground))
        )
    }
}

//#Preview {
//    ProductCard()
//}
