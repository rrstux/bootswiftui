//
//  Modal.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct Modal<Content>: View, Component where Content : View {
    var isRendered: Bool
    var isDismissable: Bool
    
    var componentTheme: Theme
    
    var background: Content?
    
    @Binding var isHidden: Bool
    
    init(isRendered: Bool = true,
         isHidden: Binding<Bool> = .constant(false),
         isDismissable: Bool = true,
         componentTheme: Theme = .primary,
         @ViewBuilder background: () -> Content?) {
        self.isRendered = isRendered
        self._isHidden = isHidden
        self.isDismissable = isDismissable
        self.componentTheme = componentTheme
        self.background = background()
    }
    
    init(isRendered: Bool = true,
         isHidden: Binding<Bool> = .constant(false),
         isDismissable: Bool = true,
         componentTheme: Theme = .primary) where Content == AnyView {
        self.init(isRendered: isRendered,
                  isHidden: isHidden,
                  isDismissable: isDismissable,
                  componentTheme: componentTheme) { AnyView(EmptyView()) }
        background = AnyView(defaultBackground)
    }
    
    var body: some View {
        ZStack {
            background.edgesIgnoringSafeArea(.all)
        }
        .opacity(isHidden ? 0 : 1)
    }
    
    var defaultBackground: some View {
        Rectangle()
            .foregroundColor(.black.opacity(0.6))
            .onTapGesture {
                withAnimation(.spring()) {
                    isHidden = true
                }
            }
    }
}

struct Modal_Previews: PreviewProvider {
    
    @State static var isHidden = false
    
    static var previews: some View {
        Modal(isHidden: $isHidden)
            .previewLayout(.sizeThatFits)
    }
}
