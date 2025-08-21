import SwiftData

final class CartService: CartServiceProtocol {
    private let context: ModelContext
    
    @MainActor
    init() {
        self.context = Persistence.shared.modelContext
    }
    
    func fetchCart() -> [Cart] {
        do {
            return try context.fetch(FetchDescriptor<Cart>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func add(_ productId: Int, _ quantity: Int) {
        context.insert(Cart(productId: productId, quantity: quantity))
        save()
    }
    
    func remove(_ productId: Int) {
        if let cart = fetchCart().first(where: { $0.productId == productId }) {
            context.delete(cart)
            save()
        }
    }
    
    func editQuantity(_ productId: Int, _ newQuantity: Int) {
        if let cart = fetchCart().first(where: { $0.productId == productId }) {
            cart.quantity = newQuantity
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
