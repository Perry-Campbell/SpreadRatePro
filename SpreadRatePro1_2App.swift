//
//  SpreadRatePro1_2App.swift
//  SpreadRateProv1.2
//
//  Created by Perry Campbell on 4/3/21.
//

import SwiftUI

@main
struct SpreadRatePro1_2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
public struct SpreadRateFunctions {
     var weight_unit: String
     var length_unit: String
//    var width_unit: String
//
     var weight: Float
     var length: Float
//    var width: Float
    
    // add desired result unit
    init(weight_unit: String, length_unit: String, weight: String, length: String) {
        self.weight_unit = weight_unit
        self.length_unit = length_unit
        
        // Avoiding division by zero
        self.weight = Float(weight) ?? 0
        self.length = Float(length)!

    }
    
    func convert_length(unit: String, value: Float) -> Float {
        switch unit.lowercased() {
        case "meters":
            return value * 3.28084
        case "kilometers":
            return value * (1000 * 3.28084)
        case "feet":
            return value
        case "yards":
            return value * 3
        case "miles":
            return value * 5280
        default:
            return 0
        }
    }
        func convert_weight(unit: String, value: Float) -> Float {
            switch unit.lowercased() {
            case "pounds":
                return value
            case "kilograms":
                return value / 2.20462
            case "tons":
                return value / 2000
            default:
                return value
            }
            
        }
    // Pounds / Yards^2
    // Pounds / Feet^2
    // Tons / Feet^2
    // Kg / Meter^2
    func results() {
        
    }
    
    
}
