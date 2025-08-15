//
//  OrderCard.swift
//  APIChallange
//
//  Created by Marcos on 13/08/25.
//

import SwiftUI

struct OrderCard: View {
    var body: some View {
        HStack {
//            AsyncImage(url:) // TODO: colocar a imagem com async quando tiver a api.
            DefaultImage(imageName: "bag.fill")
            
            HStack(spacing: 16){
                VStack (alignment: .leading, spacing: 4) {
                    Text("DELIVERY BY MONTH, 00")
                        .font(.system(.caption, weight: .regular))
                    
                    Text("Product name with two or more lines goes here")
                        .font(.system(.footnote, weight: .regular))
                        .lineLimit(1)
                    
                    Text("US$ 00,00")
                        .font(.system(.headline, weight: .bold))
                }
            }
            .padding(.trailing, 16)
        }
        .padding(.leading, 8)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    OrderCard()
}
