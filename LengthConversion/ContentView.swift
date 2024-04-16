//
//  ContentView.swift
//  LengthConversion
//
//  Created by Daniel Thierry Marcelin on 2024/4/14.
//

import SwiftUI

struct ContentView: View {
    let inputUnits = ["M", "KM", "FT", "Yard", "Miles"]
    let outputUnits = ["meters", "kilometers", "feet", "yard", "miles"]

    @State private var valueToConvert = 1.0
    @State private var unitToConvert = "KM"
    @State private var unitExpected = "meters"
    @FocusState private var isFocused: Bool
    
    var convertedValue: Double {
        let mToMeters = 1.0
        let kmToMeters = 1000.0
        let ftToMeters = 0.3048
        let yardToMeters = 0.9144
        let mileToMeters = 1609.34
        
        var totalInMeters = 1.0
        switch (unitToConvert) {
        case "M" : totalInMeters = valueToConvert * mToMeters
        case "KM": totalInMeters = valueToConvert * kmToMeters
        case "FT": totalInMeters = valueToConvert * ftToMeters
        case "Yard": totalInMeters = valueToConvert * yardToMeters
        case "Miles": totalInMeters = valueToConvert * mileToMeters
        default: totalInMeters = 0
        }
        
        switch (unitExpected) {
        case "meters": return totalInMeters
        case "kilometers": return totalInMeters / kmToMeters
        case "feet": return totalInMeters / ftToMeters
        case "yard": return totalInMeters / yardToMeters
        case "miles": return totalInMeters / mileToMeters
        default: return 0
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Unit to convert", value: $valueToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=$isFocused@*/FocusState<Bool>().projectedValue/*@END_MENU_TOKEN@*/)
                    
                    Picker("Unit to convert", selection: $unitToConvert) {
                        ForEach(inputUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input to convert")
                }
                
                Section {
                    Picker("Unit to Convert to", selection: $unitExpected) {
                        ForEach(outputUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    Text(convertedValue.formatted())
                } header: {
                    Text("Output")
                }
            }
            .navigationTitle("Length Conversion")
            .toolbar {
                if isFocused {
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
