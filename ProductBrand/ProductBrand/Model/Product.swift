//
//  Product.swift
//  ProductBrand
//
//  Created by Anand  on 14/02/23.
//

import Foundation

struct Products: Decodable {
        
    var items: [Product]
    
    enum CodingKeys: String, CodingKey {
     case items = "products"
    }
}

class Product: Decodable, Hashable, Identifiable, ObservableObject {
    
    var id: String { productId }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    var title: String = ""
    var productId: String = ""
    var imageURL: String = ""
    var brand: String = ""
    var price: [Price] = []
    var rating: Double = 0.0
    
    @Published var isFavorite: Bool = false
    @Published var isChangesApplicable: Bool = true

    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURL,brand, price
        case productId = "id"
        case rating = "ratingCount"
    }
    
    init(title: String,
         productId: String,
         imageURL: String,
         brand: String,
         price: [Price],
         rating: Double) {
        
        self.title = title
        self.productId = productId
        self.brand = brand
        self.price = price
        self.rating = rating
    }
    
    
}

struct Price: Decodable {
    
    var value: Double
    var message: String
    var isOfferPrice: Bool
    
    init(value: Double,
         message: String,
         isOfferPrice: Bool) {
        self.value = value
        self.message = message
        self.isOfferPrice = isOfferPrice
    }
}
