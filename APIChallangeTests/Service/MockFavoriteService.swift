import Foundation
@testable import APIChallange

class MockFavoriteService: FavoriteServiceProtocol {
    var favorites: [Favorite] = []
    private var favorite: Favorite
    
    init() {
        self.favorite = Favorite(productId: 1)
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
