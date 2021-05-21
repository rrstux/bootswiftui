//
//  View.swift
//  bootswiftui
//
//  Created by Robert Sandru on 21.05.2021.
//

import SwiftUI

extension View {
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
