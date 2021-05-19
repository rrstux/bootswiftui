//
//  Component.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import Foundation

protocol Component {
    
    var isRendered: Bool { get set }
    var isHidden: Bool { get set }
    var isDismissable: Bool { get set }
    
    var componentTheme: Theme { get set }
}

extension Component { }
