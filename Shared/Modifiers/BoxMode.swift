//
//  BoxMode.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI

struct BoxMode: ViewModifier {
    
    var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(theme.config.background)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(theme.config.ternary, lineWidth: 0.3))
    }
}

extension View {
    
    func boxMode(theme: Theme = .primary) -> some View {
        self.modifier(BoxMode(theme: theme))
    }
}
