//
//  ProductsList.swift
//  APIChallange
//
//  Created by Marcos on 13/08/25.
//

import SwiftUI

struct ProductsList: View {
    var hasPicker: Bool = false
    var product: Product
    @State var quantity: Int
    var onQuantityChange: ((Int) -> Void)?
    var onAddToCart: (() -> Void)?
        
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
                DefaultImage(imageName: "bag.fill", large: false)
            }
            .frame(width: 80, height: 80)
            
            HStack(spacing: 16){
                VStack (alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(.system(.footnote, weight: .regular))
                        .lineLimit(2)
                    
                    Text(product.price.formatted(
                        .currency(code: Locale.current.currency?.identifier ?? "USD")
                        .precision(.fractionLength(2))
                    ))
                        .font(.system(.headline, weight: .bold))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 62)
                
                if hasPicker {
                    HStack(spacing: 8) {
                        Button {
                            if quantity > 1 {
                                quantity -= 1
                                onQuantityChange?(quantity)
                            } else {
                                onQuantityChange?(0)
                            }
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundStyle(Color(.label))
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
                                .foregroundStyle(Color(.label))
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
                .padding(.leading, 16)
        }
        .padding(.leading, 8)
        .padding(.trailing, 16)
        .frame(width: 361, height: 94)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.secondarySystemBackground))
        )
    }
}

