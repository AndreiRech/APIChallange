//
//  CartViewModelProtocol.swift
//  APIChallange
//
//  Created by Marcos on 15/08/25.
//

import Foundation

protocol CartViewModelProtocol {
    var cartProducts: [StoredProduct] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadCartProducts()
    func removeProduct(_ product: StoredProduct)
    func updateProductQuantity(_ product: StoredProduct, quantity: Int)
}
