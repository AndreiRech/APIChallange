//
//  CategoryViewModelTest.swift
//  APIChallangeTests
//
//  Created by Andrei Rech on 21/08/25.
//

import Testing
import Foundation
@testable import APIChallange

struct CategoryViewModelTests {
    @Test func initialState() throws {
        // Given
        let viewModel = CategoryViewModel()
        
        // Then
        #expect(viewModel.searchText.isEmpty)
        #expect(viewModel.navigateToCategory == nil)
        #expect(viewModel.category == nil)
        #expect(!viewModel.filteredCategories.isEmpty)
        #expect(viewModel.filteredCategories.count == ProductCategory.allCases.count)
    }
    
    @Test func filterWithEmptySearchText() throws {
        // Given
        let viewModel = CategoryViewModel()
        viewModel.searchText = ""
        
        // When
        let result = viewModel.filteredCategories
        
        // Then
        #expect(result.count == ProductCategory.allCases.count)
    }
    
    @Test func filterWithMatchingSearchText() throws {
        // Given
        let viewModel = CategoryViewModel()
        viewModel.searchText = "beau"
        
        // When
        let result = viewModel.filteredCategories
        
        // Then
        #expect(!result.isEmpty)
        #expect(result.allSatisfy { $0.rawValue.lowercased().contains("beau") })
    }
    
    @Test func filterWithNonMatchingSearchText() throws {
        // Given
        let viewModel = CategoryViewModel()
        viewModel.searchText = "inexistente"
        
        // When
        let result = viewModel.filteredCategories
        
        // Then
        #expect(result.isEmpty)
    }
    
    @Test func navigateToCategoryAndSetCategory() throws {
        // Given
        let viewModel = CategoryViewModel()
        let category = ProductCategory.allCases.first!
        
        // When
        viewModel.navigateToCategory = category
        viewModel.category = category
        
        // Then
        #expect(viewModel.navigateToCategory == category)
        #expect(viewModel.category == category)
    }
}
