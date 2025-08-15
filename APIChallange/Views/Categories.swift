//
//  Categories.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//

import SwiftUI

struct Categories: View {
    @State var viewModel: CategoryViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ScrollView(.horizontal) {
                    HStack(alignment: .center) {
                        ForEach(viewModel.filteredCategories) { category in
                            VStack(spacing: 8) {
                                DefaultImage(imageName: category.imageName)
                                
                                Text(category.rawValue)
                                    .font(.subheadline)
                            }
                            .frame(width: 84, height: 112)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .scrollIndicators(.hidden)
                
                List(viewModel.filteredCategories) { category in
                    CategoryView(category: category)
                }
                .scrollIndicators(.hidden)
                .listStyle(.inset)
                .searchable(text: $viewModel.searchText, prompt: "Search")
            }
        }
        .navigationTitle("Categories")
    
    }
}
