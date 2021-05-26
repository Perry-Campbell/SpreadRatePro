//
//  ContentView.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 4/3/21.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            
            CalculatorUI()
            
        }// NavView
        .modifier(NavigationViewModifier())
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

extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}
