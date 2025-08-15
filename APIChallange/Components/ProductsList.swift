//
//  ProductsList.swift
//  APIChallange
//
//  Created by Marcos on 13/08/25.
//

import SwiftUI

struct ProductsList: View {
    var hasPicker: Bool = false
    var product: StoredProduct
    var onQuantityChange: ((Int) -> Void)?
    var onAddToCart: (() -> Void)?
    
    @State private var quantity: Int = 1
    
    var body: some View {
        HStack {
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
            
            HStack(spacing: 16){
                VStack (alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(.system(.footnote, weight: .regular))
                        .lineLimit(2)
                    
                    Text("US$ \(product.price.description)")
                        .font(.system(.headline, weight: .bold))
                }
                if hasPicker {
                    HStack(spacing: 8) {
                        Button {
                            if quantity > 1 {
                                quantity -= 1
                                onQuantityChange?(quantity)
                            }
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                                .frame(width: 23, height: 23)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color(.tertiarySystemFill))
                                )
                        }
                        
                        Text("\(quantity)")
                            .font(.system(.body, weight: .regular))
                        
                        Button {
                            quantity += 1
                            onQuantityChange?(quantity)
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 12, weight: .bold))
                                .frame(width: 23, height: 23)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .foregroundStyle(Color(.tertiarySystemFill))
                                )
                        }
                    }
                } else {
                    Button {
                        onAddToCart?()
                    } label: {
                        Image(systemName: "cart.fill")
                            .foregroundColor(.primary)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(Color(.tertiarySystemFill))
                            )
                    }
                }
            }
        }
        .frame(height: 94)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.secondarySystemBackground))
        )
    }
}

