//
//  Categories.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//

import SwiftUI

struct Categories: View {
    let viewModel: ProductViewModel
    
    @State var searchText = ""
    
    var filteredCategories: [ProductCategory] {
        if searchText.isEmpty {
            return ProductCategory.allCases
        } else {
            return ProductCategory.allCases.filter { $0.rawValue.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack(spacing: 16) {
                    ScrollView(.horizontal) {
                        HStack(alignment: .center) {
                            ForEach(filteredCategories) { category in
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
                    
                    List(filteredCategories) { category in
                        CategoryView(category: category)
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(.inset)
                    .searchable(text: $searchText, prompt: "Search")
                }
            }
        }
        .navigationTitle("Categories")
    }
}
