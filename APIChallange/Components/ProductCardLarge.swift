//
//  ProductCardLarge.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    @State var isFavorited: Bool = false
    var product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: product.thumbnail)) { image in
                image.resizable()
            } placeholder: {

            }
   
            VStack {
                HStack {
                    Text(product.category.uppercased())
                        .font(.footnote)
                        .foregroundStyle(Color(.secondaryLabel))
                    
                    Spacer()
                    
                    Button {
                        isFavorited.toggle()
                    } label: {
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
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
                .padding(.top, 24)
                .padding(.bottom, 32)
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
