//
//  Modal.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct Modal<Content>: View, Component where Content : View {
    var isRendered: Bool
    var isHidden: Bool
    var isDismissable: Bool
    
    var componentTheme: Theme
    
    var background: Content
    
    init(isRendered: Bool = true,
         isHidden: Bool = false,
         isDismissable: Bool = true,
         componentTheme: Theme = .primary,
         @ViewBuilder background: () -> Content) {
        self.isRendered = isRendered
        self.isHidden = isHidden
        self.isDismissable = isDismissable
        self.componentTheme = componentTheme
        self.background = background()
    }
    
    init() where Content == AnyView {
        self.init {
            AnyView(Rectangle().foregroundColor(.blue))
        }
    }
    
    var body: some View {
        ZStack {
            background
        }
    }
}

struct Modal_Previews: PreviewProvider {
    static var previews: some View {
        Modal()
            .previewLayout(.sizeThatFits)
    }
}
