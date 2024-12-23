//
//  BarCodeScannerViewModel.swift
//  BarCodeScanner
//
//  Created by Sebastian Bușa on 21.10.2024.
//

import SwiftUI

final class BarCodeScannerViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Not yet scanned" : scannedCode
    }
    
    var statusTextColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
}
