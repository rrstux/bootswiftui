//
//  Breadcrumb.swift
//  bootswiftui
//
//  Created by Robert Sandru on 25.05.2021.
//

import SwiftUI

struct Breadcrumb<Separator: View>: View, Component {
    var isRendered: Bool
    var isHidden: Bool
    var isDismissable: Bool
    var componentTheme: Theme
    
    var pages: [String]
    var separator: Separator?
    
    init(isRendered: Bool = true,
         isHidden: Bool = false,
         isDismissable: Bool = false,
         componentTheme: Theme = .primary,
         pages: [String] = [],
         @ViewBuilder separator: () -> Separator?) {
        self.isRendered = isRendered
        self.isHidden = isHidden
        self.isDismissable = isDismissable
        self.componentTheme = componentTheme
        self.pages = pages
        self.separator = separator()
    }
    
    init(isRendered: Bool = true,
         isHidden: Bool = false,
         isDismissable: Bool = false,
         componentTheme: Theme = .primary,
         pages: [String] = []) where Separator == Text {
        self.init(isRendered: isRendered,
                  isHidden: isHidden,
                  isDismissable: isDismissable,
                  componentTheme: componentTheme,
                  pages: pages) {
            Text("/")
                .foregroundColor(.gray)
                .fontWeight(.bold)
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<pages.count) { index in
                    Button(action: {
                        
                    }, label: {
                        Text(pages[index])
                            .foregroundColor(componentTheme.config.text)
                            .fontWeight(index == pages.count-1 ? .bold : .regular)
                    })
                    if index != pages.count-1 {
                        separator
                    }
                }
            }
        }
    }
}

struct Breadcrumb_Previews: PreviewProvider {
    static var previews: some View {
        Breadcrumb(isRendered: true,
                   isHidden: false,
                   isDismissable: false,
                   componentTheme: .primary,
                   pages: ["Home", "Categories", "Jokes", "Ion & Marie"])
            .padding()
    }
}
