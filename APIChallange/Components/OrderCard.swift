//
//  OrderCard.swift
//  APIChallange
//
//  Created by Marcos on 13/08/25.
//

import SwiftUI

struct OrderCard: View {
    var product: Product
    
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
            .padding(8)
            
            HStack(spacing: 16){
                VStack (alignment: .leading, spacing: 4) {
                    Text(product.shippingInformation)
                        .font(.system(.caption, weight: .regular))
                    
                    Text(product.description)
                        .font(.system(.footnote, weight: .regular))
                        .lineLimit(1)
                    
                    Text(product.price.formatted(
                        .currency(code: "BRL")
                        .precision(.fractionLength(2))
                    ))
                    .font(.system(.headline, weight: .bold))
                }
            }
            .padding(.trailing, 16)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.secondarySystemBackground))
        )
    }
}
