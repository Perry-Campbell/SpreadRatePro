//
//  ClearButton.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 5/16/21.
//

import SwiftUI

struct ClearButton: ViewModifier {
    
    @Binding var text: String
    
    public func body(content: Content) -> some View {
        ZStack (alignment: .trailing) {
            content
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "multiply.circle.fill")
                    .frame(minWidth:50)
                    .contentShape(Rectangle())
                    .padding()
                    .foregroundColor(.secondary)
            }//disabled bc frame acts as padding .padding(.trailing, 20)
            .opacity(self.text == "" ? 0 : 1)
            
        }.padding(.vertical, 2)
    }
}
