//
//  APIServiceTest.swift
//  ProductBrandTests
//
//  Created by Anand  on 14/02/23.
//

import XCTest
@testable import ProductBrand

final class APIServiceTest: XCTestCase {

    func testRetrieveProductsValidObject() {
        let apiService = MockAPIService()
        let viewModel = ProductViewModel(service: apiService)
        viewModel.apply(input: .onTestExecute)
        XCTAssertTrue(!viewModel.products.items.isEmpty)
    }
    
    func testProductEmptyObject() {
        let apiService = MockAPIService()
        let viewModel = ProductViewModel(service: apiService)
        viewModel.apply(input: .onAppear)
        XCTAssertTrue(viewModel.products.items.isEmpty)
    }
    
    func testProductApi() {
        let apiService = MockAPIService()
        let expectation = self.expectation(description: "ApiCalling")

        var mockProducts: Products?
        let _ = apiService.fetchProducts().sink { completion in
            debugPrint(completion)
        } receiveValue: { products in
           mockProducts = products
            expectation.fulfill()

        }
        
        // Wait for the expectation to be fullfilled, or time out
        // after 5 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(mockProducts)
        XCTAssertTrue((mockProducts?.items.count ?? 0) != 0)

    }
    

}
