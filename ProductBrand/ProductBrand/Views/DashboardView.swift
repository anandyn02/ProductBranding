//
//  DashboardView.swift
//  ProductBrand
//
//  Created by Anand  on 14/02/23.
//

import SwiftUI


struct DashboardView: View {
    
    enum SegmentSection: Int {
        case all
        case favorites
        
        var desc: String {
            switch self {
            case .all: return "All"
            case .favorites: return "Favorites"
            }
        }
    }
    
    @ObservedObject var viewModel: ProductViewModel
    
    @State private var segmentCurrentIndex: Int = 0
    
    var body: some View {
        NavigationView {
            List(viewModel.getProductItem(section: segmentCurrentIndex)) { item in
                ProductView(product: item)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    SegmentBar(state: $segmentCurrentIndex)
                }
            }
            .navigationTitle(SegmentSection(rawValue: segmentCurrentIndex)?.desc ?? "")
        }
        .onAppear{
            viewModel.apply(input: .onAppear)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: ProductViewModel())
    }
}
