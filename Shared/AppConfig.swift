//
//  AppConfig.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI
import Combine

class AppConfig: ObservableObject {
    
    @Published var theme: Theme = .primary
    @Published var topView: AnyView? = nil
    
    var topViewUnwrapped: AnyView {
        if topView != nil {
            return AnyView(topView!)
        } else {
            return AnyView(EmptyView())
        }
    }
}
