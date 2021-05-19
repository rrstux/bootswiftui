//
//  Component.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import Foundation

enum ComponentSize {
    case standard
    case compact
}

protocol Component {
    
    var isHidden: Bool { get set }
    var isDismissable: Bool { get set }
    
    var componentTheme: Theme { get set }
    var componentSize: ComponentSize { get set }
}

extension Component {
    
    var componentSize: ComponentSize {
        get { .compact }
        set { }
    }
}
