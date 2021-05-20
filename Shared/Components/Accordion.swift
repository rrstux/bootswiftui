//
//  Accordion.swift
//  bootswiftui
//
//  Created by Robert Sandru on 20.05.2021.
//

import SwiftUI

struct AccordionSectionData<Header: View, Content: View>: Identifiable {
    
    var id = UUID()
    var isCollapsed = true
    
    var header: () -> Header
    var content: () -> Content
}

struct Accordion<Header: View, Content: View>: View, Component {
    
    var componentTheme: Theme
    var isDismissable: Bool
    
    // MARK: Bindings
    
    @Binding var accordionSectionData: [AccordionSectionData<Header, Content>]
    
    @Binding var isRendered: Bool
    @Binding var isHidden: Bool
    
    var body: some View {
        if !isRendered {
            EmptyView()
        } else {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .boxMode(theme: componentTheme)
                    .layoutPriority(-1)
                VStack(spacing: 0) {
                    ForEach(accordionSectionData.indices) { i in
                        AccordionSection(componentTheme: componentTheme,
                                         header: accordionSectionData[i].header,
                                         content: accordionSectionData[i].content,
                                         listPosition: ListPosition.position(in: accordionSectionData.indices, of: i),
                                         isCollapsed: $accordionSectionData[i].isCollapsed)
                    }
                }
            }
            .opacity(isHidden ? 0 : 1)
        }
    }
}

fileprivate struct AccordionSection<Header: View, Content: View>: View {
    
    var componentTheme: Theme = .primary
    
    let header: () -> Header
    let content: () -> Content
    
    var listPosition: ListPosition = .unknown
    
    @Binding var isCollapsed: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.default.speed(2)) {
                    isCollapsed.toggle()
                }
            }, label: {
                HStack(alignment: .center) {
                    header()
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.up")
                        .rotationEffect(isCollapsed ? .degrees(180) : .degrees(0))
                        .foregroundColor(componentTheme.config.ternary)
                }
            })
            .padding()
            .foregroundColor(componentTheme.config.ternary)
            headerDividers()
            if isCollapsed {
                content()
                    .foregroundColor(componentTheme.config.text)
                    .padding()
                if (listPosition != .last && listPosition != .uniqueElement) {
                    Divider()
                }
            }
        }
    }
    
    func headerDividers() -> some View {
        VStack {
            if (listPosition == .uniqueElement && isCollapsed) {
                Divider()
            }
            if (listPosition == .mid || listPosition == .first) {
                Divider()
            }
            if (listPosition == .last && isCollapsed) {
                Divider()
            }
        }
    }
}

struct Accordion_Previews: PreviewProvider {
    
    @State static var firstSectionCollapsed = true
    @State static var secondSectionCollapsed = false
    
    @State static var accordionSectionData = [
        AccordionSectionData(isCollapsed: true,
                             header: { Text("Home Sweet Home") },
                             content: { Text("lol") }),
        AccordionSectionData(isCollapsed: true,
                             header: { Text("Home Sweet Home") },
                             content: { Text("lol") })
    ]
    
    static var previews: some View {
        NavigationView {
            VStack {
                Button(action: {
                    accordionSectionData[0].isCollapsed.toggle()
                }, label: {
                    Text("Button")
                })
                Accordion(componentTheme: .white,
                          isDismissable: true,
                          accordionSectionData: $accordionSectionData,
                          isRendered: .constant(true),
                          isHidden: .constant(false))
                    .padding()
                    .previewLayout(.sizeThatFits)
            }
        }
    }
}
