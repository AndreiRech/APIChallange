import Foundation

protocol OrderViewModelProtocol {
    var orderProducts: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var searchText: String { get set }
    var filteredProducts: [Product] { get }
    
    func loadOrderProducts(allProducts: [Product])
}
