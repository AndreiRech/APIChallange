//
//  DummyJSONProtocol.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation

protocol ProductsServiceProtocol {
    func getProducts() async throws -> [Product]
}
