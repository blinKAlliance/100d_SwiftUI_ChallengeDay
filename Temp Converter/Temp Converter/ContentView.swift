//
//  ContentView.swift
//  Temp Converter
//
//  Created by Jordan Kramer on 5/13/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTemperature: Double = 68
    private var temperatureUnits: Array<String> = ["Fahrenheit", "Celsius", "Kelvin"]
    @State private var baseUnit: String = "Fahrenheit"
    @State private var convertedTempUnit: String = "Celsius"

    private var newConvertedTemp: Double {
        var convertedTemperature: Double = currentTemperature
        if baseUnit == "Fahrenheit" {
            if convertedTempUnit == "Celsius" {
                convertedTemperature = (currentTemperature - 32) * (5/9)
            }
            if convertedTempUnit == "Kelvin" {
                convertedTemperature = (currentTemperature - 32) * (5/9) + 273.15
            }
        }
        if baseUnit == "Celsius" {
            if convertedTempUnit == "Fahrenheit" {
                convertedTemperature = (currentTemperature * (9/5)) + 32
            }
            if convertedTempUnit == "Kelvin" {
                convertedTemperature += 273.15
            }
        }
        if baseUnit == "Kelvin" {
            if convertedTempUnit == "Celsius" {
                convertedTemperature -= 273.15
            }
            if convertedTempUnit == "Fahrenheit" {
                convertedTemperature = (currentTemperature - 273.15) * (9/5) + 32
            }
        }
        
        return convertedTemperature
    }
    
    private func getUnit(_ temperatureUnit: String) -> String {
        return (temperatureUnit == "Fahrenheit") ? "F" : (temperatureUnit == "Celsius") ? "C" : "K"
    }
    
    private var convertedUnitSymbol: String {
        
        return ""
    }
    
    var body: some View {

        NavigationView {
            Form {
                Section {
                    TextField("Current Temperature: ", value: $currentTemperature, format: .number)
                } header: {
                    Text("Current Temperature")
                }
                
                Section {
                    Text("Convert From:")
                    Picker("Teamperature Unit", selection: $baseUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Spacer()
                    Text("Convert To:")
                    Picker("Teamperature Unit", selection: $convertedTempUnit) {
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                .listRowSeparator(.hidden)
                
                Section {
                    Text("\(newConvertedTemp, specifier: "%.2f")")
                    + Text(" ˚\(getUnit(convertedTempUnit))")
                }
            }
            .navigationTitle("Temp Converter")
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
