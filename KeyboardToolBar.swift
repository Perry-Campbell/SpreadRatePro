//
//  KeyboardToolBar.swift
//  SpreadRatePro1.2
//
//  Created by Perry Campbell on 5/14/21.
//

import SwiftUI

final class KeyboardResponder: ObservableObject {
    private var notificationCeneter: NotificationCenter
    private var enabled: Bool = false
    @Published private(set) var currentHeight: CGFloat = 0
    
    init(center: NotificationCenter = .default) {
        notificationCeneter = center
        notificationCeneter.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCeneter.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func dismiss() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    deinit {
        notificationCeneter.removeObserver(self)
    }
    
    @objc func keyBoardWillShow(notification: Notification ) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
            enabled = true
        }
    }
    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
        enabled = false
    }
    func isEnabled() -> Bool {
        return enabled
    }
}

struct KeyboardView<Content, ToolBar> : View where Content : View, ToolBar : View {
    @StateObject private var keyboard : KeyboardResponder = KeyboardResponder()
    let toolbarFrame: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 40.0)
    var content: () -> Content
    var toolBar: () -> ToolBar
    
    var body: some View {
        ZStack {
            content()
                .padding(.bottom, (keyboard.currentHeight == 0) ? 0 : toolbarFrame.height)
            VStack {
                Spacer()
                toolBar()
                    .frame(width: toolbarFrame.width, height: toolbarFrame.height)
                    .background(Color("buttonShadow"))
                    .opacity(0.7)
            }.opacity((keyboard.currentHeight == 0) ? 0 : 1)
            .animation(.easeOut)
        }
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        .animation(.easeOut)
    }
}
