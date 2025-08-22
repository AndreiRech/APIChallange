import Foundation

protocol FavoriteServiceProtocol {
    func fetchFavorites() -> [Favorite]
    func add(_ productId: Int)
    func remove(_ productId: Int)
}
