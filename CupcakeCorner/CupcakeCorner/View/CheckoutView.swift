//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Sebastian Bușa on 8/2/25.
//

import SwiftUI

struct CheckoutView: View {
    
    @Bindable var viewModel: OrderViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(viewModel.order.cost, format: .currency(code: "USD"))")
                    .font(.title.bold())
                
                Button("Place your order") {
                    Task {
                        await viewModel.placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $viewModel.showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(viewModel.confirmationMessage)
        }
        .alert("Oops.. something went wrong!", isPresented: $viewModel.failingRequest) {
            Button("OK") { }
        } message: {
            Text("Looks like the request couldn't be completed. Please try again later.")
        }
    }
}

#Preview {
    CheckoutView(viewModel: OrderViewModel())
}
