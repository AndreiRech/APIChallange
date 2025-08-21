import Foundation

protocol CartServiceProtocol {
    func fetchCart() -> [Cart]
    func add(_ productId: Int, _ quantity: Int)
    func remove(_ productId: Int)
    func editQuantity(_ productId: Int, _ newQuantity: Int)
}
