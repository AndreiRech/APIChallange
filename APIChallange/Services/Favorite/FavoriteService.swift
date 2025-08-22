import SwiftData

final class FavoriteService: FavoriteServiceProtocol {
    private let context: ModelContext
    
    @MainActor
    init() {
        self.context = Persistence.shared.modelContext
    }
    
    func fetchFavorites() -> [Favorite] {
        do {
            return try context.fetch(FetchDescriptor<Favorite>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func add(_ productId: Int) {
        context.insert(Favorite(productId: productId))
        save()
    }
    
    func remove(_ productId: Int) {
        if let fav = fetchFavorites().first(where: { $0.productId == productId }) {
            context.delete(fav)
            save()
        }
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
