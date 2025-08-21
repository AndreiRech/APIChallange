//
//  CategoryProductsViewModelProtocol.swift
//  APIChallange
//
//  Created by Andrei Rech on 15/08/25.
//

import Foundation
import SwiftUI

protocol CategoryProductsViewModelProtocol {
    var category: ProductCategory { get set }
    
    var favoriteProducts: [Product] { get set }
    var isLoading: Bool { get set }
    var errorMessage: String? { get set }
    var product: Product? { get set }
    var products: [Product] { get set }
    var searchText: String { get set }
    var filteredProducts: [Product] { get }

    func loadFavoriteProducts(allProducts: [Product])
    func isFavorite(_ productID: Int) -> Bool
    func getProducts() async
    func getProduct(by id: Int) async
    
    func addToFavorite(product: Product)
    func removeFromFavorite(product: Product)
}
