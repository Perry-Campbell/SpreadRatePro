//
//  ContentView.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 4/3/21.
//

import SwiftUI

struct ContentView: View {
    private let max_char_len = 10
    
    @State private var weight: String = ""
    @State private var length: String = ""
    @State private var width: String = ""
    @State private var result: String = "0"
    
    private var weight_units = ["Pounds","Kilograms","Tons"]
    private var length_units = ["Feet", "Yards", "Meters","Kilometers", "Miles"]
    private var width_units = ["Feet", "Yards", "Meters"]
    private var result_units = ["lbs/ft", "lbs/yds", "tons/ft", "kg/m"]
    
    @State private var selected_weight = "Pounds"
    @State private var selected_length = "Feet"
    @State private var selected_width = "Feet"
    @State private var selected_result = "lbs/yds"
    
    
    init() {
        //this changes the "thumb" that selects between items
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        //and this changes the color for the whole "bar" background
        UISegmentedControl.appearance().backgroundColor = UIColor.systemBackground

        //this will change the font size
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)

        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.label], for: .normal)
    }
    
    
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("gradientFade"), Color.blue]),
                           startPoint: .top, endPoint: .bottom).ignoresSafeArea(edges: .bottom)
                .padding(.top, 50)
            
            VStack {
                
                // Logo/Title
                HStack {
                    Text("SpreadRate")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(.trailing, -5)
                    
                    
                Text("Pro")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .padding(.vertical, 0)
                    .padding(.horizontal, 10)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(15)
                    
                }
                Divider()
                Spacer()
                
                // Result
                
                HStack(alignment: .top) {
                    if Float(result) != nil && Float(result) ?? -1 >= 0 {
                        Text(result)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 3.0)
                        Text(selected_result)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text("2")
                            .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                            .padding(.leading, -5.0)
                    }
                    else {
                        Text("Syntax Error")
                            .foregroundColor(.red)
                            .font(.title)
                            .padding()
                    }
                }.shadow(color: Color("gradientFade"), radius: 20)
                .padding(.top, 40.0)
                Picker("Select a unit for result", selection: $selected_result) {
                    ForEach(result_units, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: selected_result, perform: { value in
                    callSpreadRateFunctions()
                })
                .shadow(color: .gray, radius: 2)
                
                Spacer()
                
                VStack {
                    Divider()

                //Weight
                    TextField("Enter Weight", text: $weight).onReceive(weight.publisher.collect()) {
                        self.weight = String($0.prefix(max_char_len))
                    }
                    .textFieldStyle(OvalTextFieldStyle())
                    .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                    
                
                Picker("Select a unit for weight", selection: $selected_weight) {
                    ForEach(weight_units, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: selected_weight, perform: { value in
                    callSpreadRateFunctions()
                })
                .shadow(color: .gray, radius: 2)
                    
                //Length
                TextField("Enter Length", text: $length).onReceive(length.publisher.collect()) {
                    self.length = String($0.prefix(max_char_len))
                }
                    .textFieldStyle(OvalTextFieldStyle())
                    .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                
                Picker("Select a unit for length", selection: $selected_length) {
                    ForEach(length_units, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: selected_length, perform: { value in
                    callSpreadRateFunctions()
                })
                .shadow(color: .gray, radius: 2)
                    
                // Width
                TextField("Enter Width", text: $width).onReceive(width.publisher.collect()) {
                    self.width = String($0.prefix(max_char_len))
                }
                    .textFieldStyle(OvalTextFieldStyle())
                    .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                
                Picker("Select a unit for width", selection: $selected_width) {
                    ForEach(width_units, id: \.self) {
                        Text($0)
                    }
                }.onChange(of: selected_width, perform: { value in
                        callSpreadRateFunctions()
                    })
                .shadow(color: .gray, radius: 2)
                    
                    
                Divider()
                } // embedded VStack
                
                
                // Calculate button
                Button(action: {
                    callSpreadRateFunctions()
                    buttonPressed()
                    
                }, label: {
                    Text("Calculate")
                })
                .padding(.horizontal, 30.0)
                .padding(.vertical, 15)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(144)
                .shadow(color: .gray, radius: 2)
                
                Spacer()
            }
            /* VStack modifiers*/
            .padding(.horizontal, 5)
            .padding(.bottom, 100)
            .multilineTextAlignment(.center)
            .pickerStyle(SegmentedPickerStyle())
            
        }
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
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
            
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 15)
            .background(Color("textfieldBackground"))
            .cornerRadius(10)
            .shadow(color: Color("buttonShadow"), radius: 2)
    }
}
