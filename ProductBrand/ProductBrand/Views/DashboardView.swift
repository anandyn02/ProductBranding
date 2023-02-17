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
        case favourites
        
        var desc: String {
            switch self {
            case .all: return "All"
            case .favourites: return "Favourites"
            }
        }
    }
    
    @ObservedObject var viewModel: ProductViewModel
    
    @State private var segmentCurrentIndex: Int = 0
            
    @State var didRefresh: Bool = false

    var body: some View {
        ZStack {
            
            if self.viewModel.isApiLoading {
                ProgressView().zIndex(1)
            }
            
            NavigationView {
                List(viewModel.getProductItem(section: segmentCurrentIndex, onRefresh: didRefresh)) { item in
                    ProductView(product: item)
                    .onReceive(item.$isFavorite) { flag in
                        if segmentCurrentIndex == 1 && item.isChangesApplicable {
                            didRefresh.toggle()
                        }
                    }
                    .onReceive(item.$isChangesApplicable) { flag in
                        if flag {
                            didRefresh.toggle()
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        SegmentBar(state: $segmentCurrentIndex)
                    }
                }
                .navigationTitle(SegmentSection(rawValue: segmentCurrentIndex)?.desc ?? "")
            }.zIndex(0)
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
