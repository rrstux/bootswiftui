//
//  ModalPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct ModalPresentationScreen: View {
    
    @State var isHidden: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                isHidden.toggle()
            }, label: {
                Text("Button")
            })
        }
        .modal(isHidden: $isHidden) {
            VStack {
                Text("lOL")
            }
        }
    }
}

struct ModalPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        ModalPresentationScreen()
    }
}
