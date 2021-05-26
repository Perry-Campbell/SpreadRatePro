//
//  NavigationViewModifier.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 5/26/21.
//

import SwiftUI

struct NavigationViewModifier: ViewModifier {
    
        init() {
               let navBarAppearance = UINavigationBarAppearance()
               navBarAppearance.configureWithOpaqueBackground()
               navBarAppearance.backgroundColor = UIColor.systemRed

               UINavigationBar.appearance().standardAppearance = navBarAppearance
        }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                
                ZStack {
                    GeometryReader { geometry in
                        Color("launchScreenBackground")
                            .frame(height: geometry.safeAreaInsets.top + 50)
                            .edgesIgnoringSafeArea(.top)
                        HStack {
                            Spacer()
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
                            
                            Spacer()
                            
                        } // HStack
                        
                    } // GeoReader
                    Spacer()
                } // Embedded ZStack
                
            } // VStack
            
        } // ZStack
        
    } // Body
    
} // View

