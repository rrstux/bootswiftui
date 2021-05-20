//
//  AccordionPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 20.05.2021.
//

import SwiftUI

struct AccordionPresentationScreen: View {
    
    @State var firstSectionCollapsed = true
    @State var secondSectionCollapsed = false
    
    var body: some View {
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
    }
}

struct AccordionPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccordionPresentationScreen()
    }
}
