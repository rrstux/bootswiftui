//
//  Modal.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct ModalModifier<ModalContent>: ViewModifier where ModalContent : View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Binding var isHidden: Bool
    var modalContent: ModalContent
    
    @State private var screenSize: CGSize = .zero
    
    init(isHidden: Binding<Bool> = .constant(false),
         @ViewBuilder modalContent: () -> ModalContent) {
        self._isHidden = isHidden
        self.modalContent = modalContent()
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear(perform: topViewModalConfig)
            .onChange(of: isHidden, perform: { _ in topViewModalConfig() })
    }
    
    func topViewModalConfig() {
        if !isHidden {
            appConfig.topView = AnyView(Modal(isHidden: $isHidden))
        } else {
            appConfig.topView = AnyView(EmptyView())
        }
    }
}

extension View {
    
    func modal<Content: View>(isHidden: Binding<Bool>, content: () -> Content) -> some View {
        self.modifier(ModalModifier(isHidden: isHidden, modalContent: content))
    }
}
