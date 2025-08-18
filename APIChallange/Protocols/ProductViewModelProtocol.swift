//
//  ProductViewModelProtocol.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation

protocol ProductViewModelProtocol {
    var product: Product? { get }
    var products: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func getProducts() async
    func getProduct(by id: Int) async
    func addProductToStorage(product: Product, isFavorite: Bool, isOnCart: Bool, isOrdered: Bool)
}
