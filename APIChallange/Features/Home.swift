//
//  ContentView.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct Home: View {
    let viewModel: ProductViewModel
    let favoriteViewModel: FavoriteViewModelProtocol
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var selectedProduct: Product?
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Deals of the day")
                            .font(.system(.title2, weight: .bold))
                        if let product = viewModel.product {
                            ProductCardLarge(productViewModel: ProductViewModel(service: ProductService(), database: SwiftDataService.shared), favoriteViewModel: FavoriteViewModel(database: SwiftDataService.shared),
                                product: product,
                                isFavorite: favoriteViewModel.isFavorite(product.id))
                            .onTapGesture {
                                selectedProduct = product
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)
                    .scrollIndicators(.hidden)
                    
                    VStack (alignment: .leading) {
                        Text("Top Picks")
                            .font(.system(.title2, weight: .bold))
                        
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.products) { product in
                                ProductCard(productViewModel: ProductViewModel(service: ProductService(), database: SwiftDataService.shared), isFavorite: favoriteViewModel.isFavorite(product.id), product: product)
                                    .onTapGesture {
                                        selectedProduct = product
                                    }
                            }
                            .refreshable {
                                await viewModel.getProducts()
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
            await viewModel.getProducts()
            favoriteViewModel.loadFavoriteProducts(allProducts: viewModel.products)
            await viewModel.getProduct(by: 1)
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetails(viewModel: viewModel, productID: product.id, isFavorite: favoriteViewModel.isFavorite(product.id))
        }
    }
}

//#Preview {
//    ContentView()
//}
