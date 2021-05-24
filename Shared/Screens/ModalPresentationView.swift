//
//  ModalPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct ModalPresentationScreen: View {
    
    @State var isHidden: Bool = true
    
    var body: some View {
        VStack {
            Button(action: {
                isHidden.toggle()
            }, label: {
                Text("Button")
            })
        }
        .modal(isHidden: $isHidden, content: Text("Lol").eraseToAnyView(), controls: HStack {
            Button(action: {}, label: {
                Text("Button")
                    .bootswiftuiButton(theme: .danger, type: .regular)
            })
        }.eraseToAnyView())
    }
}

struct ModalPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresentationScreen()
            .environmentObject(AppConfig())
    }
}
