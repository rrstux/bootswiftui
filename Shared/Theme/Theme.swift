//
//  Theme.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI

protocol ThemeProtocol {
    
    var name: String { get set }
    
    var primary: Color { get }
    var secondary: Color { get }
    var ternary: Color { get }
    
    var background: Color { get set }
    var border: Color { get set }
    var text: Color { get set }
}

extension ThemeProtocol {
    
    var background: Color {
        get { primary }
        set { }
    }
    
    var text: Color {
        get { ternary }
        set { }
    }
    
    var border: Color {
        get { secondary }
        set { }
    }
}

struct Primary: ThemeProtocol {
    
    var name: String = "Primary"
    
    var primary: Color = .primaryBlue
    var secondary: Color = .secondaryBlue
    var ternary: Color = .ternaryBlue
}

struct Secondary: ThemeProtocol {
    
    var name: String = "Secondary"
    
    var primary: Color = .primaryGray
    var secondary: Color = .secondaryGray
    var ternary: Color = .ternaryGray
}

struct Success: ThemeProtocol {
    
    var name: String = "Success"
    
    var primary: Color = .primaryGreen
    var secondary: Color = .secondaryGreen
    var ternary: Color = .ternaryGreen
}

struct Danger: ThemeProtocol {
    
    var name: String = "Danger"
    
    var primary: Color = .primaryRed
    var secondary: Color = .secondaryRed
    var ternary: Color = .ternaryRed
}

struct Warning: ThemeProtocol {
    
    var name: String = "Warning"
    
    var primary: Color = .primaryYellow
    var secondary: Color = .secondaryYellow
    var ternary: Color = .ternaryYellow
}

struct Info: ThemeProtocol {
    
    var name: String = "Info"
    
    var primary: Color = .primaryLightBlue
    var secondary: Color = .secondaryLightBlue
    var ternary: Color = .ternaryLightBlue
}

struct Dark: ThemeProtocol {
    
    var name: String = "Dark"
    
    var primary: Color = .primaryDarkGray
    var secondary: Color = .secondaryDarkGray
    var ternary: Color = .ternaryDarkGray
}

struct White: ThemeProtocol {
    
    var name: String = "White"
    
    var primary: Color = .primaryWhite
    var secondary: Color = .secondaryWhite
    var ternary: Color = .ternaryWhite
}

enum Theme: CaseIterable {
    case primary
    case secondary
    case success
    case danger
    case warning
    case info
    case dark
    case white
    
    var config: ThemeProtocol {
        switch self {
        case .primary: return Primary()
        case .secondary: return Secondary()
        case .success: return Success()
        case .danger: return Danger()
        case .warning: return Warning()
        case .info: return Info()
        case .dark: return Dark()
        case .white: return White()
        }
    }
}
