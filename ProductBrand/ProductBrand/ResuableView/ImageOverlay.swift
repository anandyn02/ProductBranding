//
//  ImageOverlay.swift
//  ProductBrand
//
//  Created by Anand  on 14/02/23.
//

import SwiftUI

struct ImageOverlay: View {
    @Binding var isSelected: Bool
    @State var imageName: String = "heart"
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isSelected = !isSelected
                imageName = isSelected ? "heart_sel" : "heart"
                
            }) {
                Image(imageName)
                    .renderingMode(.original)
            }
            .frame(width: 40, height: 40)
            .buttonStyle(.borderless)
        }
        //.background(Color.black)
        .opacity(1.0)
        .cornerRadius(20.0)
        .padding()
        
        .onAppear {
            imageName = isSelected ? "heart_sel" : "heart"
        }
    }
}


struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let price = Price(value: 0.0, message: "", isOfferPrice: false)
        let product = Product(
            title: "Some Title",
            productId: "123",
            imageURL: "https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM",
            brand: "My Brand",
            price: [price],
            rating: 4.0)
        ProductView(product: product)
    }
}
