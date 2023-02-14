//
//  ProductBrandApp.swift
//  ProductBrand
//
//  Created by Anand  on 13/02/23.
//

import SwiftUI

@main
struct ProductBrandApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView(viewModel: ProductViewModel())
        }
    }
}
