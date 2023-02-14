//
//  MockRequest.swift
//  ProductBrandTests
//
//  Created by Anand  on 14/02/23.
//

import Foundation
import Combine
@testable import ProductBrand

final class MockRequest: APIRequest {
    typealias Response = Products
    
    var path: String { "2f06b453-8375-43cf-861a-06e95a951328" }
    
    var queryItems: [URLQueryItem]?
    
}
