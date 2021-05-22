//
//  AccordionPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 20.05.2021.
//

import SwiftUI

struct AccordionPresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedColorScheme: ColorScheme = .dark
    
    @State var accordionSectionData = MockData.Acordion_FAQ.list.map { mockData in
        AccordionSectionData(isCollapsed: false, header: { Text(mockData.question) }, content: { Text(mockData.answer) })
    }
    
    @State var isRendered = true
    @State var isHidden = false
    
    var body: some View {
        VStack {
            Accordion(componentTheme: appConfig.theme,
                      isDismissable: true,
                      isRendered: isRendered,
                      isHidden: isHidden,
                      accordionSectionData: $accordionSectionData)
                .padding()
                .layoutPriority(1)
            
            Form {
                Section(header: Text("Rendering")) {
                    Toggle(isOn: $isRendered) {
                        Label(
                            title: { Text("Rendered") },
                            icon: { Image(systemName: "eye") }
                        )
                    }
                    Toggle(isOn: $isHidden) {
                        Label(
                            title: { Text("Hidden") },
                            icon: { Image(systemName: "eye") }
                        )
                    }
                }
                Section(header: Text("Control")) {
                    Button(action: {
                        withAnimation {
                            collapseRandomSection()
                        }
                    }, label: {
                        Label(
                            title: { Text("Collapse Randomly") },
                            icon: { Image(systemName: "eye") }
                        )
                    })
                    Button(action: {
                        withAnimation {
                            collapseRandomSection(closeOthers: false)
                        }
                    }, label: {
                        Label(
                            title: { Text("Collapse Randomly keeping active") },
                            icon: { Image(systemName: "eye") }
                        )
                    })
                    Button(action: {
                        withAnimation {
                            collapse(all: false)
                        }
                    }, label: {
                        Label(
                            title: { Text("Close all") },
                            icon: { Image(systemName: "eye") }
                        )
                    })
                    Button(action: {
                        withAnimation(.default) {
                            collapse(all: true)
                        }
                    }, label: {
                        Label(
                            title: { Text("Open all") },
                            icon: { Image(systemName: "eye") }
                        )
                    })
                }
                
                Section(header: Text("Themes")) {
                    Picker(selection: $selectedColorScheme, label: Text("Picker")) {
                        Text("Dark Mode").tag(ColorScheme.dark)
                        Text("Light Mode").tag(ColorScheme.light)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    ThemeSwitcher(selectedTheme: $appConfig.theme)
                }
            }
        }
        .preferredColorScheme(selectedColorScheme)
        .onAppear {
            selectedColorScheme = colorScheme
        }
        .navigationTitle("Accordions")
    }
    
    func collapseRandomSection(closeOthers: Bool = true) {
        if closeOthers {
            accordionSectionData = accordionSectionData.map {
                AccordionSectionData(isCollapsed: false, header: $0.header, content: $0.content)
            }
        }
        accordionSectionData[Int.random(in: accordionSectionData.indices)].isCollapsed = true
    }
    
    func collapse(all toValue: Bool = true) {
        accordionSectionData = accordionSectionData.map {
            AccordionSectionData(isCollapsed: toValue, header: $0.header, content: $0.content)
        }
    }
}

struct AccordionPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccordionPresentationScreen()
                .environmentObject(AppConfig())
        }
    }
}
