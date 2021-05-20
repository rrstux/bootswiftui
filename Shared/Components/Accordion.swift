//
//  Accordion.swift
//  bootswiftui
//
//  Created by Robert Sandru on 20.05.2021.
//

import SwiftUI

struct Accordion<Section: View>: View, Component {
    
    var componentTheme: Theme
    var isDismissable: Bool
    
    // MARK: Bindings
    @Binding var isRendered: Bool
    @Binding var isHidden: Bool
    
    @ViewBuilder var sections: () -> Section
    
    @Environment(\.colorScheme) var colorScheme
    
    init(componentTheme: Theme,
         isDismissable: Bool,
         isRendered: Binding<Bool>,
         isHidden: Binding<Bool>,
        @ViewBuilder sections: @escaping () -> Section) {
        self.componentTheme = componentTheme
        self.isDismissable = isDismissable
        self._isRendered = isRendered
        self._isHidden = isHidden
        self.sections = sections
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .boxMode(theme: .white)
                .layoutPriority(-1)
            VStack(spacing: 0) {
                sections()
            }
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
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.default.speed(2)) {
                    isCollapsed.toggle()
                }
            }, label: {
                HStack(alignment: .center) {
                    header
                    Spacer()
                    Image(systemName: "chevron.up")
                        .rotationEffect(isCollapsed ? .degrees(180) : .degrees(0))
                }
            })
            .padding()
            Divider()
            if isCollapsed {
                content
                    .padding()
                Divider()
            }
        }
    }
}

struct Accordion_Previews: PreviewProvider {
    
    @State static var firstSectionCollapsed = true
    @State static var secondSectionCollapsed = false
    
    static var previews: some View {
        NavigationView {
            Accordion(componentTheme: .white,
                      isDismissable: true,
                      isRendered: .constant(true),
                      isHidden: .constant(false)) {
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
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
