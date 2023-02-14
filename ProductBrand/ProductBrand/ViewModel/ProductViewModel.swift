//
//  ProductViewModel.swift
//  ProductBrand
//
//  Created by Anand  on 14/02/23.
//

import Foundation
import Combine

final class ProductViewModel: ViewModel {
    
    private let productService: ProductService
    
    init(service: ProductService = ProductService()) {
        self.productService = service
        bind()
    }
        
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    var cancellables: [AnyCancellable] = []

    @Published var products: Products = Products(items: [])
    @Published var favorites: [Product] = []


    enum Input: Equatable {
        case onAppear
        case onTestExecute
    }
    
    func apply(input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send()
        case .onTestExecute: prepareMockObject()
        }
    }
    
    private func bind() {
        onAppearSubject
            .flatMap { [productService] _ in
                productService.fetchProducts()
            }
            .assign(to: \.products, on: self)
            .store(in: &cancellables)
    }
    
    func getProductItem(section: Int) -> [Product] {
        let segment = SegmentSection.allCases[section]
        switch segment {
        case .all:
            return products.items
        default:
            return products.items.filter {$0.isFavorite}
            
        }
    }
    
    func prepareMockObject() {
        let product = Product(
            title: "Mock Title",
            productId: "123",
            imageURL: "",
            brand: "Mock Brand", price: [], rating: 0.4)
        products.items.append(product)
    }
}
