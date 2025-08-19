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
    
    func addToFavorite(product: Product)
    func addToCart(product: Product)
    func addToOrder(product: Product)
    
    
}
