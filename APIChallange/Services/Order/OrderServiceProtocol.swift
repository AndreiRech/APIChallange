import Foundation

protocol OrderServiceProtocol {
    func fetchOrders() -> [Order]
    func add(_ productId: Int)
}
