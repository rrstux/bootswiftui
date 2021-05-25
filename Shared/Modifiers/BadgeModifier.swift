//
//  BadgeModifier.swift
//  bootswiftui
//
//  Created by Robert Sandru on 25.05.2021.
//

import SwiftUI

struct BadgeModifier: ViewModifier {
    
    var theme: Theme
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(theme.config.background)
            .foregroundColor(theme.config.text)
            .cornerRadius(15)
    }
}

extension View {
    
    func badge(theme: Theme = .primary) -> some View {
        self.modifier(BadgeModifier(theme: theme))
    }
}

