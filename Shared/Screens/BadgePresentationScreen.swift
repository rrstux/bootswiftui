//
//  BadgePresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 25.05.2021.
//

import SwiftUI

struct BadgePresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedColorScheme: ColorScheme = .dark
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Audi is produced in ")
                    Text("GERMANY")
                        .fontWeight(.bold)
                        .badge(theme: appConfig.theme)
                    Spacer()
                }
                HStack {
                    Text("Romania")
                        .fontWeight(.bold)
                        .badge(theme: .danger)
                    Text(" is the home of Dracula.")
                    Spacer()
                }
                HStack {
                    Image(systemName: "swift")
                        .badge(theme: .danger)
                    Image(systemName: "swift")
                        .badge(theme: .warning)
                    Image(systemName: "swift")
                        .badge(theme: .primary)
                    Image(systemName: "swift")
                        .badge(theme: .success)
                    Image(systemName: "swift")
                        .badge(theme: .white)
                    Image(systemName: "swift")
                        .badge(theme: .dark)
                }
            }
            .padding()
            Form {
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
        .navigationTitle("Badges")
    }
}

struct BadgePresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BadgePresentationScreen()
                .environmentObject(AppConfig())
        }
    }
}
