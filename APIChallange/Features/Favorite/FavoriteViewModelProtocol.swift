import Foundation

protocol FavoriteViewModelProtocol {
    var favoriteProducts: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    var searchText: String { get set }
    var filteredProducts: [Product] { get }
    
    func loadFavoriteProducts(allProducts: [Product])
    func isFavorite(_ productID: Int) -> Bool
}
