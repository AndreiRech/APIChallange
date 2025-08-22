import SwiftData

final class OrderService: OrderServiceProtocol {
    private let context: ModelContext
    
    @MainActor
    init() {
        self.context = Persistence.shared.modelContext
    }
    
    func fetchOrders() -> [Order] {
        do {
            return try context.fetch(FetchDescriptor<Order>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func add(_ productId: Int) {
        context.insert(Order(productId: productId))
        save()
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
