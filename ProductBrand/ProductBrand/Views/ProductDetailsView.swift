//
//  ProductDetailsView.swift
//  ProductBrand
//
//  Created by Anand  on 14/02/23.
//

import SwiftUI

struct ProductDetailsView: View {
    @State var product: Product
    
    @State private var showsAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            let url = URL(string: product.imageURL)!
            URLImage(url: url)
                .frame(width: UIScreen.main.bounds.width, height: 200)
            
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
            
            Text("Rating: $\(String(format: "%.2f", product.rating ))")
                .foregroundColor(.black)
                .font(.title3)
            
            Spacer()
            
        }
        .padding()
        .navigationTitle(product.title)
        .overlay(ImageOverlay(isSelected: $product.isFavorite), alignment: .topTrailing)
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let price = Price(value: 0.0, message: "", isOfferPrice: false)
        let product = Product(
            title: "Some Title",
            productId: "123",
            imageURL: "https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM",
            brand: "My Brand",
            price: [price],
            rating: 4.0)
        ProductDetailsView(product: product)
    }
}
