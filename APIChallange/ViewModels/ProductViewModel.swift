//
//  ProductViewModel.swift
//  APIChallange
//
//  Created by Marcos on 14/08/25.
//

import Foundation

@Observable
class ProductViewModel: ProductViewModelProtocol, ObservableObject {
    var product: Product?

    var products: [Product] = []

    var isLoading: Bool = false

    var errorMessage: String?
    
    private let service: ProductsServiceProtocol
    
    private let database: SwiftDataService
   
    init(service: ProductsServiceProtocol, database: SwiftDataService) {
        self.service = service
        self.database = database
    }
    
    func getProducts() async {
        isLoading = true
        
        do {
            products = try await service.getProducts()
        }  catch {
            errorMessage = "Error to fetch products \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func getProduct(by id: Int) async {
        if products.isEmpty {
            await getProducts()
        }
        
        if let product = products.first(where: { $0.id == id }) {
            self.product = product
        }
    }
    
    func addProductToStorage(product: Product, isFavorite: Bool = false, isOnCart: Bool = false, isOrdered: Bool = false) {
        database.addProduct(StoredProduct(
            id: product.id,
            title: product.title,
            details: product.description,
            category: product.category,
            price: product.price,
            shippingInformation: product.shippingInformation,
            thumbnail: product.thumbnail,
        ))
    }
    
    func addToFavorite(product: Product) {
        database.addToFavorite(product.id)
    }
    
    func getProductsFromStorage() -> [Cart] {
        return database.fetchCartProducts()
    }
    
    func removeProductFromCart(_ product: StoredProduct) {
        database.removeProduct(product)
    }
}
