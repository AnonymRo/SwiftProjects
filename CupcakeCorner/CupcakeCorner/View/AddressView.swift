//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Sebastian Bușa on 7/2/25.
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var viewModel: OrderViewModel
    
    var body: some View {
        Form {
            Section("Personal data") {
                TextField("Name", text: trimmedBinding(for: $viewModel.order.name))
                TextField("Street address", text: $viewModel.order.streetAddress)
                TextField("City", text: trimmedBinding(for: $viewModel.order.city))
                TextField("Zip Code", text: $viewModel.order.zip)
            }
            .padding(10)
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(viewModel: viewModel)
                }
            }
            .disabled(viewModel.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Informations")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func trimmedBinding(for text: Binding<String>) -> Binding<String> {
        Binding(
            get: { text.wrappedValue },
            set: { text.wrappedValue = $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        )
    }
}

#Preview {
    AddressView(viewModel: OrderViewModel())
}
