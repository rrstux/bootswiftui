//
//  AlertPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI

struct AlertPresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @State var isDismissable = true
    @State var isRendered = true
    @State var isHidden = false
    
    @State var titleShown = true
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedColorScheme: ColorScheme = .dark
    
    var body: some View {
        
        VStack {
            Alert(alertTitle: titleShown ? "Hey, you!" : nil,
                  alertDescription: "Don't forget to reset your password in 24 hours. Otherwise, things can get bad.",
                  componentTheme: appConfig.theme,
                  isDismissable: isDismissable,
                  isRendered: $isRendered,
                  isHidden: $isHidden)
                .frame(height: 200)
                .padding()
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
                Section(header: Text("Appeareance")) {
                    Toggle(isOn: $isDismissable) {
                        Label(
                            title: { Text("Dismissable") },
                            icon: { Image(systemName: "eye") }
                        )
                    }
                    Toggle(isOn: $titleShown) {
                        Label(
                            title: { Text("Title") },
                            icon: { Image(systemName: "eye") }
                        )
                    }
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
        .padding(1)
        .navigationTitle("Alerts")
        .preferredColorScheme(selectedColorScheme)
        .onAppear {
            selectedColorScheme = colorScheme
        }
    }
}

struct AlertPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlertPresentationScreen()
                .environmentObject(AppConfig())
        }
    }
}
