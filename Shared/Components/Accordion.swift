//
//  Accordion.swift
//  bootswiftui
//
//  Created by Robert Sandru on 20.05.2021.
//

import SwiftUI

struct Accordion<Sections: View>: View, Component {
    
    var componentTheme: Theme
    var isDismissable: Bool
    
    // MARK: Bindings
    @Binding var isRendered: Bool
    @Binding var isHidden: Bool
    
    @ViewBuilder var sections: Sections
    
    var body: some View {
        VStack {
            sections
        }
    }
}

struct AccordionSection<Header: View, Content: View>: View {
    
    let header: Header
    let content: Content
    
    @Binding var isCollapsed: Bool
    
    init(isCollapsed: Binding<Bool>,
         @ViewBuilder header: @escaping () -> Header,
         @ViewBuilder content: @escaping () -> Content) {
        self.header = header()
        self.content = content()
        self._isCollapsed = isCollapsed
    }
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.linear) {
                    isCollapsed.toggle()
                }
            }, label: {
                HStack(alignment: .center) {
                    header
                    Spacer()
                    Image(systemName: isCollapsed ? "chevron.up" : "chevron.down")
                }
            })
            if isCollapsed {
                content
            }
        }
    }
}

struct Accordion_Previews: PreviewProvider {
    
    @State static var firstSectionCollapsed = true
    @State static var secondSectionCollapsed = false
    
    static var previews: some View {
        Accordion(componentTheme: .white,
                  isDismissable: true,
                  isRendered: .constant(true),
                  isHidden: .constant(false),
                  sections: {
                    Group {
                        AccordionSection(isCollapsed: $firstSectionCollapsed) {
                            Text("Welcome to the jungle, Honey!")
                        } content: {
                            Text("Ok, this is pretty fun.")
                        }
                        AccordionSection(isCollapsed: $secondSectionCollapsed) {
                            Text("Second Accordion Section")
                        } content: {
                            Text("Weird behavior?")
                        }

                    }
                  }
        )
        .previewLayout(.sizeThatFits)
    }
}
