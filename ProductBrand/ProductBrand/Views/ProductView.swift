//
//  ProductView.swift
//  ProductBrand
//
//  Created by Anand  on 14/02/23.
//

import SwiftUI

struct ProductView: View {
    
    @State var product: Product
    
    @State private var showsAlert = false

    var body: some View {
        ZStack(alignment: .leading){
        
            LazyVStack(alignment: .leading, spacing: 10) {
                URLImage(urlString: product.imageURL)
                    .frame(width: 100, height: 100)
                
                Text(product.title)
                    .foregroundColor(.black)
                    .font(.title3)
                
                HStack(spacing: 10) {
                    Text("Price: $\(String(format: "%.2f", product.price.first?.value ?? 0))")
                        .foregroundColor(.black)
                        .font(.body)
                    Spacer()
                    Button(action: {
                        self.showsAlert.toggle()
                    }, label: {
                        Text("Add Cart")
                    })
                    .buttonStyle(.borderless)
                    .alert(isPresented: self.$showsAlert) {
                        Alert(title: Text("\(product.title) added to cart"))
                    }
                    .frame(width: 100, height: 30)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    
                }
                Spacer()
            }
            .overlay(ImageOverlay(isSelected: $product.isFavorite), alignment: .topTrailing)
            NavigationLink(destination: ProductDetailsView(product: product)) {
               // Text("Do Something")
            }
        }
        .padding(4)
    }
}

