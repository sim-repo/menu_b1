import Foundation

class ProductFilter {
    var productId: Int
    var filterId: Int
    
    init(productId: Int, filterId: Int) {
        self.productId = productId
        self.filterId = filterId
    }
    
    public static func list()->[ProductFilter] {
        return [
            ProductFilter(productId: 1, filterId: 1),
            ProductFilter(productId: 1, filterId: 2),
            ProductFilter(productId: 1, filterId: 3),
            ProductFilter(productId: 2, filterId: 1),
            ProductFilter(productId: 1, filterId: 3)
        ]
    }
}

