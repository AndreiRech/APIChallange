//
//  ProductsList.swift
//  APIChallange
//
//  Created by Marcos on 13/08/25.
//

import SwiftUI

struct ProductsList: View {
    var hasPicker: Bool = false
    
    var body: some View {
        HStack {
//            AsyncImage(url:) // TODO: colocar a imagem com async quando tiver a api.
            Image(.placeholder)
                .resizable()
                .frame(width: 78, height: 78)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            HStack(spacing: 16){
                VStack (alignment: .leading, spacing: 4) {
                    Text("Product name with two or more lines goes here")
                        .font(.system(.footnote, weight: .regular))
                    
                    Text("US$ 00,00")
                        .font(.system(.headline, weight: .bold))
                }
                if hasPicker {
                    HStack(spacing: 8) {
                        Image(systemName: "minus")
                            .font(.system(size: 12, weight: .bold))
                            .frame(width: 23, height: 23)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(Color(.tertiarySystemFill))
                            )
                        
                        Text("1")
                            .font(.system(.body, weight: .regular))
                        
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .bold))
                            .frame(width: 23, height: 23)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(Color(.tertiarySystemFill))
                            )
                            
                    }
                } else {
                    Button {
                        // action
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
    ProductsList(hasPicker: true)
}
