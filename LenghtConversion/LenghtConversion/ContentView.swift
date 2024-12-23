//
//  ContentView.swift
//  LenghtConversion
//
//  Created by Sebastian Bușa on 10/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputLength: Double = 0.0
    @State private var inputUnit: UnitLength = .meters
    @State private var outputLength: Double = 0.0
    @State private var outputUnit: UnitLength = .centimeters
    
    let availableUnits: [UnitLength] = [.centimeters, .meters, .kilometers]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Enter length", value: $inputLength, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Section("From") {
                    Picker("Distance unit", selection: $inputUnit) {
                        ForEach(availableUnits, id: \.self) { unit in
                            Text(unit.symbol)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("To") {
                    Picker("Distance unit", selection: $outputUnit) {
                        ForEach(availableUnits, id: \.self) { unit in
                            Text(unit.symbol)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Section("Output") {
                    if inputLength > 0 {
                        Text("\(convertedMeasurement, specifier: "%.2f") \(outputUnit.symbol)")
                    } else {
                        Text("Enter a length to see the result")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Lenght Convertor")
        }
    }
    
    var convertedMeasurement: Double {
        
        let inputMeasurement = Measurement(value: inputLength, unit: inputUnit)
        let converted = inputMeasurement.converted(to: outputUnit)
        return converted.value
    }
}

#Preview {
    ContentView()
}
