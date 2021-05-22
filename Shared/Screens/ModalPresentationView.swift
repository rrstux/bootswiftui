//
//  ModalPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct ModalPresentationScreen: View {
    
    @State var isModalShown: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                isModalShown.toggle()
            }, label: {
                Text("Button")
            })
        }
        .modal(isPresented: $isModalShown) {
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
