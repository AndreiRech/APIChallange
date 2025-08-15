//
//  CategoryViewModel.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//

import Foundation
import SwiftUI

@Observable
class CategoryViewModel: CategoryViewModelProtocol {
    var searchText: String = ""
    
    var filteredCategories: [ProductCategory] {
        if searchText.isEmpty {
            return ProductCategory.allCases
        } else {
            return ProductCategory.allCases.filter { $0.rawValue.lowercased().contains(searchText.lowercased()) }
        }
    }
}
