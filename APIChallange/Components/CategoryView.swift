//
//  CategoryView.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//
import SwiftUI

struct CategoryView: View {
    var category: ProductCategory
    
    var body: some View {
        HStack(alignment: .center) {
            Text(category.stringLocalized)
                .listRowInsets(EdgeInsets())
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color(.tertiaryLabel))
                .frame(width: 12, height: 16)
        }
        .padding(.vertical, 19)
    }
}

#Preview {
    CategoryView(category: ProductCategory.beauty)
}
