import Foundation

protocol HomeViewModelProtocol {
    var favoriteProducts: [Product] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func loadFavoriteProducts(allProducts: [Product])
    func isFavorite(_ productID: Int) -> Bool
    
    var product: Product? { get }
    var products: [Product] { get }
    func getProducts() async
    func getProduct(by id: Int) async
    
    func addToFavorite(product: Product)
    func removeFromFavorite(product: Product)
    
    var iPadTopPicks: [Product] { get }
    var iPadBestSellers: [Product]? { get }
    var iPadDealsOfTheDay: [Product]? { get }
}
