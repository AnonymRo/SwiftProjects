//
//  Alert.swift
//  BarCodeScanner
//
//  Created by Sebastian Bușa on 21.10.2024.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(
            title: "Invalid device input",
            message: "Something is wrong with the camera. We are unable to capture the input.",
            dismissButton: .default(Text("Ok"))
        )
        
        static let invalidScannedType = AlertItem(
            title: "Invalid code",
            message: "The value scanned is not valid. This app scans EAN-8 and EAN-13 barcodes.",
            dismissButton: .default(Text("Ok"))
        )
}
