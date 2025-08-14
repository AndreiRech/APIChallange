//
//  ContentView.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct ContentView: View {
    let viewmodel: ProductViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            if viewmodel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewmodel.products) { product in
                            ProductCard(product: product)
                        }
                        .navigationBarTitle("Products")
                        .refreshable {
                            await viewmodel.getProducts()
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await viewmodel.getProducts()
        }
    }
}

//#Preview {
//    ContentView()
//}
