//
//  ContentView.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct Home: View {
    let viewmodel: ProductViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            if viewmodel.isLoading {
                ProgressView()
            } else {
                ScrollView() {
                    VStack(alignment: .leading) {
                        Text("Deals of the day")
                            .font(.system(.title2, weight: .bold))
                        if let product = viewmodel.product {
                            ProductCardLarge(product: product)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .scrollIndicators(.hidden)
                    
                    VStack (alignment: .leading) {
                        Text("Top Picks")
                            .font(.system(.title2, weight: .bold))
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewmodel.products) { product in
                                ProductCard(product: product)
                            }
                            .refreshable {
                                await viewmodel.getProducts()
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .scrollIndicators(.hidden)
                }
                .navigationTitle("Home")
            }
        }
        
        .task {
            await viewmodel.getProducts()
            await viewmodel.getProduct(by: 1)
        }
    }
}

//#Preview {
//    ContentView()
//}
