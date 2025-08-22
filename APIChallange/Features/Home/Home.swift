//
//  ContentView.swift
//  APIChallange
//
//  Created by Andrei Rech on 13/08/25.
//

import SwiftUI

struct Home: View {
    var viewModel: HomeViewModelProtocol
    @State var selectedProduct: Product?
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    let iPadDealsOfTheDayColumns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 2)
    let iPadVerticalColumns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 4)
    let iPadHorizontalColumns = Array(repeating: GridItem(.flexible(), spacing: 16), count: 5)
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    ViewThatFits {
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            // Horizontal
                            VStack {
                                VStack(alignment: .leading) {
                                    Text("Deals of the day")
                                        .font(.system(.title2, weight: .bold))
                                    if let deals = viewModel.iPadDealsOfTheDay {
                                        LazyVGrid(columns: iPadDealsOfTheDayColumns) {
                                            ForEach(deals) { product in
                                                ProductCardLarge(isFavorite: viewModel.isFavorite(product.id), product: product, isLarge: true) { product, isFav in
                                                    if isFav {
                                                        viewModel.addToFavorite(product: product)
                                                    } else {
                                                        viewModel.removeFromFavorite(product: product)
                                                    }
                                                }
                                                .onTapGesture {
                                                    selectedProduct = product
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                                .padding(.bottom, 24)
                                .scrollIndicators(.hidden)
                                
                                VStack (alignment: .leading) {
                                    Text("Top Picks")
                                        .font(.system(.title2, weight: .bold))
                                    
                                    LazyVGrid(columns: iPadHorizontalColumns, spacing: 16) {
                                        ForEach(viewModel.products) { product in
                                            ProductCard(isFavorite: viewModel.isFavorite(product.id), product: product, isLarge: true) { product, isFav in
                                                if isFav {
                                                    viewModel.addToFavorite(product: product)
                                                } else {
                                                    viewModel.removeFromFavorite(product: product)
                                                }
                                            }
                                            .onTapGesture {
                                                selectedProduct = product
                                            }
                                        }
                                        .refreshable {
                                            await viewModel.getProducts()
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                                .scrollIndicators(.hidden)
                            }
                            
                            // Vertical
                            VStack {
                                VStack(alignment: .leading) {
                                    Text("Deals of the day")
                                        .font(.system(.title2, weight: .bold))
                                    if let deals = viewModel.iPadDealsOfTheDay {
                                        LazyVGrid(columns: iPadDealsOfTheDayColumns) {
                                            ForEach(deals) { product in
                                                ProductCardLarge(isFavorite: viewModel.isFavorite(product.id), product: product, isLarge: false) { product, isFav in
                                                    if isFav {
                                                        viewModel.addToFavorite(product: product)
                                                    } else {
                                                        viewModel.removeFromFavorite(product: product)
                                                    }
                                                }
                                                .onTapGesture {
                                                    selectedProduct = product
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                                .padding(.bottom, 24)
                                .scrollIndicators(.hidden)
                                
                                VStack (alignment: .leading) {
                                    Text("Top Picks")
                                        .font(.system(.title2, weight: .bold))
                                    
                                    LazyVGrid(columns: iPadVerticalColumns, spacing: 16) {
                                        ForEach(viewModel.iPadTopPicks) { product in
                                            ProductCard(isFavorite: viewModel.isFavorite(product.id), product: product, isLarge: false) { product, isFav in
                                                if isFav {
                                                    viewModel.addToFavorite(product: product)
                                                } else {
                                                    viewModel.removeFromFavorite(product: product)
                                                }
                                            }
                                            .onTapGesture {
                                                selectedProduct = product
                                            }
                                        }
                                        .refreshable {
                                            await viewModel.getProducts()
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                                .padding(.bottom, 16)
                                .scrollIndicators(.hidden)
                                
                                VStack (alignment: .leading) {
                                    Text("Best Sellers")
                                        .font(.system(.title2, weight: .bold))
                                    
                                    if let bestSellers = viewModel.iPadBestSellers {
                                        LazyVGrid(columns: iPadVerticalColumns, spacing: 16) {
                                            ForEach(bestSellers) { product in
                                                ProductCard(isFavorite: viewModel.isFavorite(product.id), product: product, isLarge: false) { product, isFav in
                                                    if isFav {
                                                        viewModel.addToFavorite(product: product)
                                                    } else {
                                                        viewModel.removeFromFavorite(product: product)
                                                    }
                                                }
                                                .onTapGesture {
                                                    selectedProduct = product
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 32)
                                .scrollIndicators(.hidden)
                            }
                            
                        } else {
                            // iPhone
                            VStack {
                                VStack(alignment: .leading) {
                                    Text("Deals of the day")
                                        .font(.system(.title2, weight: .bold))
                                    if let product = viewModel.product {
                                        ProductCardLarge(isFavorite: viewModel.isFavorite(product.id), product: product) { product, isFav in
                                            if isFav {
                                                viewModel.addToFavorite(product: product)
                                            } else {
                                                viewModel.removeFromFavorite(product: product)
                                            }
                                        }
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
                                            ProductCard(isFavorite: viewModel.isFavorite(product.id), product: product) { product, isFav in
                                                if isFav {
                                                    viewModel.addToFavorite(product: product)
                                                } else {
                                                    viewModel.removeFromFavorite(product: product)
                                                }
                                            }
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
                        }
                    }
                }
                .navigationTitle("Home")
            }
        }
        .task {
            await viewModel.getProducts()
            viewModel.loadFavoriteProducts(allProducts: viewModel.products)
            await viewModel.getProduct(by: 1)
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetails(viewModel: ProductViewModel(productService: ProductService(), favoriteService: FavoriteService(), cartService: CartService(), orderService: OrderService()), productID: product.id, isFavorite: viewModel.isFavorite(product.id))
        }
    }
}

//#Preview {
//    ContentView()
//}
