//
//  BorderSpinner.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct BorderSpinner: View, Component {
    
    var isRendered: Bool
    var isHidden: Bool
    var isDismissable: Bool
    var componentTheme: Theme
    
    var isLoading: Bool
    
    var body: some View {
        if isRendered {
            GeometryReader { reader in
                Path { path in
                    path.addArc(center: .init(x: reader.size.width/2, y: reader.size.height/2),
                                radius: reader.size.width/2,
                                startAngle: .degrees(90),
                                endAngle: .degrees(180),
                                clockwise: true)
                }
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .square))
                .foregroundColor(componentTheme.config.ternary)
                .rotationEffect(isLoading ? .degrees(360) : .degrees(0))
                .animation(isLoading ? .linear.speed(0.5).repeatForever(autoreverses: false) : .default)

            }
            .opacity(isHidden ? 0 : 1)
        } else {
            EmptyView()
        }
    }
}

struct BorderSpinner_Previews: PreviewProvider {
    static var previews: some View {
        BorderSpinner(isRendered: true,
                      isHidden: true,
                      isDismissable: false,
                      componentTheme: .primary,
                      isLoading: false)
    }
}
