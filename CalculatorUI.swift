//
//  CalculatorUI.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 5/26/21.
//

import SwiftUI

struct CalculatorUI: View {
    
    
    private let max_char_len = 10
    
    @State private var weight: String = ""
    @State private var length: String = ""
    @State private var width: String = ""
    @State private var result: String = "0"
    
    private var weight_units = ["Gallons", "Pounds","Kilograms","Tons"]
    private var length_units = ["Feet", "Yards", "Meters","Kilometers", "Miles"]
    private var width_units = ["Feet", "Yards", "Meters"]
    private var result_units = ["gal/yd", "lbs/ft", "lbs/yd", "tons/ft", "tons/yd",
                                "kg/m"]
    
    @State private var selected_weight = "Pounds"
    @State private var selected_length = "Feet"
    @State private var selected_width = "Feet"
    @State private var selected_result = "lbs/yd"
    
    init() {
        //this changes the "thumb" that selects between items
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        //and this changes the color for the whole "bar" background
        UISegmentedControl.appearance().backgroundColor = UIColor.systemBackground

        //this will change the font size
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .subheadline)], for: .application)
        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.label], for: .normal)
    }
    
    var body: some View {
        ZStack {
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
            }
            LinearGradient(gradient: Gradient(colors: [Color("gradientFade"), Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(edges: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                .padding(.top, 50)
            KeyboardView {

                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                    
                
            
                    VStack {

                        // banner ad
                        GADBannerViewController()
                            .padding()
                        
                        
                        Spacer()
                        
                        // Result
                        
                        HStack(alignment: .top) {
                            if Float(result) != nil && Float(result) ?? -1 >= 0 {
                                Text(result)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .padding(.trailing, 3.0)
                                let resDisplayed = selected_result + "²"
                                Text(resDisplayed)
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            }
                            else if (result == "err-gal") {
                                Text("Cannot convert gallons to weight units")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .padding()
                            }
                            else {
                                Text("Syntax Error")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .fontWeight(Font.Weight.bold)
                                    .padding()
                            }
                        }.shadow(color: Color("gradientFade"), radius: 20)
                        .padding(.top, 40.0)
                        Picker("Select a unit for result", selection: $selected_result) {
                            ForEach(result_units, id: \.self) {
                                let strText = $0 + "²"
                                Text(strText)
                            }
                        }.onChange(of: selected_result, perform: { value in
                            if(selected_result.lowercased().contains("gal")){
                                selected_weight = "Gallons"
                            }
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
                            .modifier(ClearButton(text: $weight))
                            .textFieldStyle(OvalTextFieldStyle())
                            .keyboardType(/*@START_MENU_TOKEN@*/.decimalPad/*@END_MENU_TOKEN@*/)
                            
                            
                        
                        Picker("Select a unit for weight", selection: $selected_weight) {
                            ForEach(weight_units, id: \.self) {
                                Text($0)
                            }
                        }.onChange(of: selected_weight, perform: { value in
                            if selected_weight.lowercased().contains("gallons") {
                                selected_result = "gal/yd"
                            }
                            callSpreadRateFunctions()
                        })
                        .shadow(color: .gray, radius: 2)
                            
                        //Length
                        TextField("Enter Length", text: $length).onReceive(length.publisher.collect()) {
                            self.length = String($0.prefix(max_char_len))
                        }
                            .modifier(ClearButton(text: $length))
                            .textFieldStyle(OvalTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
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
                            .modifier(ClearButton(text: $width))
                            .textFieldStyle(OvalTextFieldStyle())
                            .keyboardType(.decimalPad)
                        
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
                    .offset(y: -40)
                    .multilineTextAlignment(.center)
                    .pickerStyle(SegmentedPickerStyle())
                    
                }) //Scroll View
                
                
            } // Keyboard View
                toolBar: {
                    HStack {
                        Spacer()
                        Button(action: {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }, label: {
                            Text("Done")
                        })
                    }.padding()
                }
        
        }
        
    }
    func callSpreadRateFunctions(){
        
        if !(weight.isEmpty || length.isEmpty || width.isEmpty) {
            let a: SpreadRateFunctions
            

            if (selected_weight.lowercased().contains("gallons") || selected_result.lowercased().contains("gal")) {
                if (selected_weight.lowercased().contains("gallons") != selected_result.lowercased().contains("gal")) {
                    result = "err-gal"
                    return
                }
            }
                                

                a = SpreadRateFunctions(weight_unit: selected_weight, length_unit: selected_length, width_unit: selected_width, result_unit: selected_result, weight: weight, length: length, width: width)
                result = a.getResults()
            
        }
        
    }
    func buttonPressed() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
