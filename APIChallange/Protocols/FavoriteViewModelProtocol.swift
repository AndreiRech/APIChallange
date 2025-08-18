import Foundation

protocol FavoriteViewModelProtocol {
    var favoriteProducts: [StoredProduct] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadFavoriteProducts()
}
