//
//  ContentView.swift
//  TemperatureConversion
//
//  Created by Roger on 2020/9/2.
//  Copyright © 2020 Roger. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputNumber = "0"
    @State private var inputUnit = UnitKind.Celsius
    @State private var outputUnit = UnitKind.Fahrenheit
    
    enum UnitKind: String, CaseIterable {
        case Celsius, Fahrenheit, Kelvin
    }
    
    private var convertTemperature: Double {
        let inputvar = Double(inputNumber) ?? 0.0
        if(inputUnit == outputUnit) {
            return inputvar
        }
        
        var convertinput: Double
        switch inputUnit {
        case .Fahrenheit:
            convertinput = (inputvar - 32.0) * (5.0 / 9.0)
        case .Kelvin:
            convertinput = inputvar - 273.15
        default:
            convertinput = inputvar
        }
        
        var convertoutput: Double
        switch outputUnit {
        case .Fahrenheit:
            convertoutput = convertinput * (9.0 / 5.0) + 32.0
        case .Kelvin:
            convertoutput = convertinput + 273.15
        default:
            convertoutput = convertinput
        }
        
        return convertoutput
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature:", text: $inputNumber).keyboardType(.decimalPad)
                }
                
                Section(header: Text("Input Unit")) {
                    Picker("Input Unit:", selection: $inputUnit) {
                        ForEach(0 ..< UnitKind.allCases.count) {
                            Text("\(UnitKind.allCases[$0].rawValue)").tag(UnitKind.allCases[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output Unit")) {
                    Picker("Output Unit:", selection: $outputUnit) {
                        ForEach(0 ..< UnitKind.allCases.count) {
                            Text("\(UnitKind.allCases[$0].rawValue)").tag(UnitKind.allCases[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("\(inputNumber) \(inputUnit.rawValue) to \(outputUnit.rawValue) is \(convertTemperature, specifier: "%.3f")")
                }
            }.navigationBarTitle("Temparature Convert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
