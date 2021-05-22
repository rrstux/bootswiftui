//
//  BootswiftuiButton.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

enum BootswiftuiButtonType {
    case regular
    case outline
}

fileprivate struct BootswiftuiButtonRegular: ViewModifier {
    
    var theme: Theme
    var type: BootswiftuiButtonType
    
    func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .boxMode(theme: theme, type: type == .regular ? .regular : .outline)
                .layoutPriority(-1)
            content
                .foregroundColor(theme.config.text)
                .padding()
        }
        .foregroundColor(theme.config.background)
    }
}

extension View {
    
    func bootswiftuiButton(theme: Theme, type: BootswiftuiButtonType) -> some View {
        return self.modifier(BootswiftuiButtonRegular(theme: theme, type: type))
    }
}
