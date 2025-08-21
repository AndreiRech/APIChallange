import Foundation
@testable import APIChallange

class MockOrderService: OrderServiceProtocol {
    var orders: [Order] = []
    
    init(orders: [Order] = [Order(productId: 1)]) {
        self.orders = orders
    }
    
    func fetchOrders() -> [Order] {
        orders
    }
    
    func add(_ productId: Int) {
        let order = Order(productId: productId)
        orders.append(order)
    }
}
