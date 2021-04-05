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
    @State private var width: String = ""
    @State private var result: String = "0"
    
    private var weight_units = ["Pounds","Kilograms","Tons"]
    private var length_units = ["Feet", "Yards", "Meters","Kilometers", "Miles"]
    private var width_units = ["Feet", "Yards", "Meters"]
    private var result_units = ["lbs/yds", "lbs/ft", "tons/ft", "kg/m"]
    
    @State private var selected_weight = "Pounds"
    @State private var selected_length = "Feet"
    @State private var selected_width = "Feet"
    @State private var selected_result = "lbs/yds"
    
    
    
    var body: some View {
        
        VStack {
            // Logo/Title
            Text("SpreadRate Pro")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            // Result
            HStack(alignment: .top) {
 //               Text("Spread Rate: ").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(result).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.trailing, 3.0)
                Text(selected_result).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("2").font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
            }
            Picker("Select a unit for result", selection: $selected_result) {
                ForEach(result_units, id: \.self) {
                    Text($0)
                }
            }.onChange(of: selected_result, perform: { value in
                callSpreadRateFunctions()
            })
            
            Spacer()
            
            VStack {
            
            //Weight
            TextField("Enter Weight", text: $weight)
                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                .padding()
            Picker("Select a unit for weight", selection: $selected_weight) {
                ForEach(weight_units, id: \.self) {
                    Text($0)
                }
            }.onChange(of: selected_width, perform: { value in
                callSpreadRateFunctions()
            })
            
            //Length
            TextField("Enter Length", text: $length)
                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                .padding()
            Picker("Select a unit for length", selection: $selected_length) {
                ForEach(length_units, id: \.self) {
                    Text($0)
                }
            }.onChange(of: selected_width, perform: { value in
                callSpreadRateFunctions()
            })
            
            // Width
            TextField("Enter Width", text: $width)
                .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                .padding()
            Picker("Select a unit for length", selection: $selected_width) {
                ForEach(width_units, id: \.self) {
                    Text($0)
                }
            }.onChange(of: selected_width, perform: { value in
                    callSpreadRateFunctions()
                })
                
            } // embedded VStack
            
            Spacer()
            
            // Calculate button
            Button(action: {
                callSpreadRateFunctions()
                buttonPressed()
                
            }, label: {
                Text("Calculate")
            })
            .padding()
            
        }
        /* VStack modifiers*/
        .multilineTextAlignment(.center)
        .pickerStyle(SegmentedPickerStyle())
        
        
    }
    
    // Dismiss keyboard on button press
    func buttonPressed() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    func callSpreadRateFunctions(){
        
        if !(weight.isEmpty || length.isEmpty || width.isEmpty) {
                
            let a = SpreadRateFunctions(weight_unit: selected_weight, length_unit: selected_length, width_unit: selected_width,
                                        result_unit: selected_result, weight: weight, length: length, width: width)
            result = a.getResults()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
