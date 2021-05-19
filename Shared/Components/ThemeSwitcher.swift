//
//  ThemeSwitcher.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI

struct ThemeSwitcher: View {
    
    @Binding var selectedTheme: Theme
    
    var body: some View {
        List {
            ForEach(Theme.allCases.indices) { index in
                Button(action: {
                    selectedTheme = activeTheme(index)
                }, label: {
                    HStack {
                        Text(activeTheme(index).config.name)
                            .fontWeight(selectedTheme == activeTheme(index) ? .bold : .regular)
                        Spacer()
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(activeTheme(index).config.primary)
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(activeTheme(index).config.secondary)
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(activeTheme(index).config.ternary)
                    }
                })
            }
        }
    }
    
    func activeTheme(_ index: Int) -> Theme {
        return Theme.allCases[index]
    }
}

struct ThemeSwitcher_Previews: PreviewProvider {
    
    @State static var selectedTheme: Theme = .primary
    
    static var previews: some View {
        ThemeSwitcher(selectedTheme: $selectedTheme)
            .previewLayout(.sizeThatFits)
    }
}
