//
//  ProductCardLarge.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct ProductCardLarge: View {
    @State var isFavorited: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            Image(.placeholder)
                .resizable()
                .frame(width: 160, height: 160)
                .cornerRadius(8)
            
            VStack {
                HStack {
                    Text("CATEGORY")
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
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Product name with two or more lines goes here")
                        .font(.subheadline)
                        .lineLimit(2)
                    
                    Text("US$ 00,00")
                        .font(.headline)
                }
                
                Spacer()
            }
        }
        .padding(8)
        .frame(width: 361, height: 176)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    ProductCardLarge()
}
