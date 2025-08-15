//
//  CategoryProductsViewModelProtocol.swift
//  APIChallange
//
//  Created by Andrei Rech on 15/08/25.
//

import Foundation
import SwiftUI

protocol CategoryProductsViewModelProtocol {
    var searchText: String { set get }
    var category: ProductCategory { get }
    var filteredProducts: [Product] { get }
    var productViewModel: ProductViewModelProtocol { get }
    func loadProducts() async
}
