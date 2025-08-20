//
//  ProductCardLarge.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    let productViewModel: ProductViewModel = .init(service: ProductService(), database: .shared)
    let favoriteViewModel: FavoriteViewModel = .init(database: .shared)
    var product: Product
    @State var isFavorite: Bool = false
    
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
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(.subheadline)
                        .lineLimit(2)
                    
                    Text("US$ \(product.price.description)")
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
    }
}

//#Preview {
//    ProductCardLarge()
//}
