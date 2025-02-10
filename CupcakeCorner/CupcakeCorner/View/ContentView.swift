//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Sebastian Bușa on 7/2/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = OrderViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Cupcake selection") {
                    Picker("Select your cake type", selection: $viewModel.order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(viewModel.order.quantity)", value: $viewModel.order.quantity, in: 1...20, step: 1)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: Binding(
                        get: { viewModel.order.specialRequestEnabled },
                        set: { newValue in viewModel.updateSpecialRequests(newValue) }
                    ))
                    
                    if viewModel.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $viewModel.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $viewModel.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery Details") {
                        AddressView(viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}

