//
//  ContentView.swift
//  Shared
//
//  Created by Robert Sandru on 16.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Accordions", destination: AccordionPresentationScreen())
                NavigationLink("Alerts", destination: AlertPresentationScreen())
            }
            .navigationTitle("bootswiftui")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppConfig())
    }
}
