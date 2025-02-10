//
//  OrderViewModel.swift
//  CupcakeCorner
//
//  Created by Sebastian Bușa on 10/2/25.
//

import Foundation
import Observation

@Observable
class OrderViewModel {
    var order: Order {
        didSet {
            saveToUserDefaults()
        }
    }
    var confirmationMessage = ""
    var showingConfirmation = false
    var failingRequest = false
    
    init() {
        if let savedOrder = OrderViewModel.loadFromUserDefaults() {
            self.order = savedOrder
        } else {
            self.order = Order()
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: Data(encoded))
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            failingRequest = true
            //print("Checkout failed: \(error.localizedDescription)")
        }
    }
    
    func updateSpecialRequests(_ isEnabled: Bool) {
        order.specialRequestEnabled = isEnabled
        if !isEnabled {
            order.extraFrosting = false
            order.addSprinkles = false
        }
    }
    
    func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(order) {
            UserDefaults.standard.set(encoded, forKey: "SavedOrder")
        }
    }
    
    static func loadFromUserDefaults() -> Order? {
        if let savedData = UserDefaults.standard.data(forKey: "SavedOrder") {
            let decodedOrder = try? JSONDecoder().decode(Order.self, from: savedData)
            return decodedOrder
        }
        return nil
    }
}
