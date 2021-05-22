//
//  GrowSpinner.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct GrowSpinner: View, Component {
    
    var isLoading: Bool
    var componentTheme: Theme
    
    // MARK: Bindables
    
    var isRendered: Bool
    var isHidden: Bool
    
    internal var isDismissable: Bool
    
    var body: some View {
        if isRendered {
            VStack {
                Circle()
                    .scaleEffect(isLoading ? 1 : 0)
                    .opacity(isLoading ? 0: 1)
            }
            .animation(isLoading ? .linear.speed(0.5).repeatForever(autoreverses: false) : .default)
            .foregroundColor(componentTheme.config.ternary)
            .opacity(isHidden ? 0 : 1)
        } else {
            EmptyView()
        }
    }
}

struct GrowSpinner_Previews: PreviewProvider {
    
    static var previews: some View {
        GrowSpinner(isLoading: false,
                    componentTheme: .dark,
                    isRendered: true,
                    isHidden: false,
                    isDismissable: false)
            .previewLayout(.sizeThatFits)
    }
}
