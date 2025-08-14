//
//  DefaultImage.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//

import SwiftUI

struct DefaultImage: View {
    var imageName: String
    var large: Bool = false
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .padding(.horizontal, large ? 48 : 16)
            .padding(.vertical, large ? 48 : 20)
            .frame(width: large ? 160 : 84, height: large ? 160 : 84)
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
