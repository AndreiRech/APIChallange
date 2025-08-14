//
//  DefaultImage.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//

import SwiftUI

struct DefaultImage: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
            .frame(width: 84, height: 84)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(Color(.secondarySystemBackground))
            )
            .foregroundStyle(Color(.secondarySystemFill))
    }
}

#Preview {
    DefaultImage(imageName: ProductCategory.allCases.first!.rawValue)
}
