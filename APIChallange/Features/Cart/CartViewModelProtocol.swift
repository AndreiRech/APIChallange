//
//  CartViewModelProtocol.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import Foundation

protocol CartViewModelProtocol {
    var cartProducts: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var totalSum: Double { get }
    
    func loadCartProducts(allProducts: [Product])
    func removeProduct(_ productId: Int)
    func updateProductQuantity(_ productId: Int, quantity: Int)
    func getQuantity(by id: Int) -> Int
    func clearCart()
}
