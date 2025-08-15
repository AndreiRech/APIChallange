//
//  CategoryViewModelProtocol.swift
//  APIChallange
//
//  Created by Andrei Rech on 14/08/25.
//

import Foundation
import SwiftUI

protocol CategoryViewModelProtocol {
    var searchText: String { set get }
    var navigateToCategory: ProductCategory? { set get }
    var category: ProductCategory? { set get }
    var filteredCategories: [ProductCategory] { get }
}
