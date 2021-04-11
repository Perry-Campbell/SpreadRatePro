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
    var width_unit: String
    var result_unit: String
    var weight: Float
    var length: Float
    var width: Float
    
    // add desired result unit
    init(weight_unit: String, length_unit: String, width_unit: String, result_unit: String, weight: String, length: String, width: String) {
        self.weight_unit = weight_unit
        self.length_unit = length_unit
        self.width_unit = width_unit
        self.result_unit = result_unit
        // Avoiding division by zero
        self.weight = Float(weight) ?? -1
        self.length = Float(length) ?? -1
        self.width = Float(width) ?? -1
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
                return value * 2.20462
            case "tons":
                return value * 2000
            default:
                return value
            }
            
        }
    
    //float units should be in ft when passed to function
    func convert_result(result_unit: String, weight: Float, length: Float, width: Float) -> Float {
        
        let units = result_unit.split(separator: "/")
        
        var numerator: Float
        var denominator: Float
        
        switch units[0] {
            case "lbs":
                numerator = weight
            case "kg":
                numerator = weight / 2.20462
            case "tons":
                numerator = weight / 2000
            default:
                numerator = 0
        }
        switch units[1] {
            case "ft":
                denominator = length * width
            case "yds":
                denominator = (length / 3) * (width / 3)
                
            case "m":
                denominator = (length / 3.28084) * (width / 3.28084)
                
            default:
                denominator = 1
        }
        
        return numerator / denominator
    }
    
    
    func getResults() -> String {
        let weight = self.convert_weight(unit: self.weight_unit, value: self.weight)
        let length = self.convert_length(unit: self.length_unit, value: self.length)
        let width = self.convert_length(unit: self.width_unit, value: self.width)
        if weight < 0 || length <= 0 || width <= 0 {
            return "-1"
        }
        
        let res = convert_result(result_unit: self.result_unit, weight: weight, length: length, width: width)
        

        return String(res)

    }
    
}
