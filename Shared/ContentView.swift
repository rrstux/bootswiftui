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
        VStack {
            Text("Hello, world!")
                .foregroundColor(appConfig.theme.config.text)
                .padding()
            ThemeSwitcher(selectedTheme: $appConfig.theme)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppConfig())
    }
}
