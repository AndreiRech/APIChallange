import Foundation
@testable import APIChallange

class MockOrderService: OrderServiceProtocol {
    var orders: [Order] = []
    private var order: Order
    
    init() {
        self.order = Order(productId: 1)
    }
    
    func fetchOrders() -> [Order] {
        orders
    }
    
    func add(_ productId: Int) {
        let order = Order(productId: productId)
        orders.append(order)
    }
}
