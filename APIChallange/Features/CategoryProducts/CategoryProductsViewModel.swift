//
//  CategoryProductsViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 15/08/25.
//

import Foundation
import SwiftUI

@Observable
class CategoryProductsViewModel: CategoryProductsViewModelProtocol {
    var searchText: String = ""

    var productViewModel: ProductViewModelProtocol
    var category: ProductCategory
    var products: [Product] {
        productViewModel.products
    }
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return products.filter { $0.category == category.rawValue.lowercased() }
        } else {
            return products.filter { $0.category == category.rawValue.lowercased() && $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    func loadProducts() async {
        await productViewModel.getProducts()
    }
    
    init(category: ProductCategory, productViewModel: ProductViewModelProtocol) {
        self.category = category
        self.productViewModel = productViewModel
    }
}
