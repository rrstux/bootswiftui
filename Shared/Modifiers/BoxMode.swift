//
//  BoxMode.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI

enum BoxModeType {
    case regular
    case outline
}

struct BoxMode: ViewModifier {
    
    var theme: Theme
    var type: BoxModeType = .regular
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(type == .regular ? theme.config.background : .clear)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(theme.config.ternary, lineWidth: type == .regular ? 0.5 : 1))
    }
}

extension View {
    
    func boxMode(theme: Theme = .primary, type: BoxModeType = .regular) -> some View {
        self.modifier(BoxMode(theme: theme, type: type))
    }
}
