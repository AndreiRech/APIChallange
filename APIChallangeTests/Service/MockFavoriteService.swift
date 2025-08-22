import Foundation
@testable import APIChallange

class MockFavoriteService: FavoriteServiceProtocol {
    var favorites: [Favorite] = []
    
    init(favorites: [Favorite] = [Favorite(productId: 1)], startEmpty: Bool = false) {
        if !startEmpty {
            self.favorites = favorites
        } else {
            self.favorites = []
        }
    }
    
    func fetchFavorites() -> [Favorite] {
        favorites
    }
    
    func add(_ productId: Int) {
        favorites.append(Favorite(productId: productId))
    }
    
    func remove(_ productId: Int) {
        if let index = favorites.firstIndex(where: { $0.productId == productId }) {
            favorites.remove(at: index)
        }
    }
}
