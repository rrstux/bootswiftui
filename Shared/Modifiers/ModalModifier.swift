//
//  ModalModifier.swift
//  bootswiftui
//
//  Created by Robert Sandru on 24.05.2021.
//

import SwiftUI

struct ModalModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    
    func modal(isShowing: Binding<Bool>) -> some View {
        self.modifier(ModalModifier())
    }
}
