//
//  ContentView.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var weight: String = ""
    @State private var length: String = ""
    @State private var result: String = ""
    
    private var weight_units = ["Pounds","Kilograms","Tons"]
    private var length_units = ["Feet", "Yards", "Meters","Kilometers", "Miles"]
    @State private var selected_weight = "Pounds"
    @State private var selected_length = "Feet"
    
    
    
    var body: some View {
        
        VStack {
            
            Text("SpreadRate Pro")
                .padding()
            Text(result)
            
            //Weight
            TextField("Enter Weight", text: $weight)
                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                .padding()
            Picker("Select a unit for weight", selection: $selected_weight) {
                ForEach(weight_units, id: \.self) {
                    Text($0)
                }
            }
            
            //Length
            TextField("Enter Length", text: $length)
                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                .padding()
            Picker("Select a unit for length", selection: $selected_length) {
                ForEach(length_units, id: \.self) {
                    Text($0)
                }
            }
            
            
            
            Button(action: {
                if !(weight.isEmpty || length.isEmpty) {
                    result = calculate(width: weight, length: length)
                    callSpreadRateFunctions()
                    buttonPressed()
                }
            }, label: {
                Text("Calculate")
            })
            .padding()
            
        }
        /* VStack modifiers*/
        .multilineTextAlignment(.center)
        .pickerStyle(SegmentedPickerStyle())
        .ignoresSafeArea()
        
        
    }
    func calculate(width: String, length: String) -> String {
        var valid:Bool = true
        var res: String = ""
        if Float(width) == nil{
            res.append("Width is invalid")
            valid = false
        }
        if Float(length) == nil{
            res.append("\nLength is invalid")
            valid = false
        }
        if valid {
            res = String(Float(width)! + Float(length)!)
        }
       
        
        return String(res)
    }
    func buttonPressed() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func callSpreadRateFunctions(){
        let a = SpreadRateFunctions(weight_unit: selected_weight, length_unit: selected_length, weight: weight, length: length)
        result = String(a.convert_length(unit: a.length_unit, value: a.length) * a.convert_weight(unit: a.weight_unit, value: a.weight))
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
