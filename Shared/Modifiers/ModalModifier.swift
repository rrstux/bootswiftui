//
//  Modal.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct ModalModifier<ModalContent>: ViewModifier where ModalContent : View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Binding var isPresented: Bool
    var modalContent: ModalContent
    
    @State private var screenSize: CGSize = .zero
    
    init(isPresented: Binding<Bool> = .constant(false),
         @ViewBuilder modalContent: () -> ModalContent) {
        self._isPresented = isPresented
        self.modalContent = modalContent()
    }
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented, perform: { value in
                if isPresented {
                    appConfig.topView = AnyView(Modal(isHidden: $isPresented))
                }
            })
    }
}

extension View {
    
    func modal<Content: View>(isPresented: Binding<Bool>, content: () -> Content) -> some View {
        self.modifier(ModalModifier(isPresented: isPresented, modalContent: content))
    }
}
