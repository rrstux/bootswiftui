//
//  AccordionPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 20.05.2021.
//

import SwiftUI

struct AccordionPresentationScreen: View {
    @EnvironmentObject var appConfig: AppConfig
    
    @State var accordionSectionData = MockData.Acordion_FAQ.list.map { mockData in
        AccordionSectionData(isCollapsed: false, header: { Text(mockData.question) }, content: { Text(mockData.answer) })
    }
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    
                    accordionSectionData[0].isCollapsed = false
                }
            }, label: {
                Text("Button")
            })
            Accordion(componentTheme: appConfig.theme,
                      isDismissable: true,
                      accordionSectionData: $accordionSectionData,
                      isRendered: .constant(true),
                      isHidden: .constant(false))
                .padding()
            ThemeSwitcher(selectedTheme: $appConfig.theme)
        }
    }
}

struct AccordionPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccordionPresentationScreen()
    }
}
