//
//  ModalPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 24.05.2021.
//

import SwiftUI

struct ModalPresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedColorScheme: ColorScheme = .dark
    
    @State var isLoading = false
    @State var isRendered = true
    @State var isHidden = false
    @State var isAutoScrolling = true
    
    var body: some View {
        VStack {
            Modal(isRendered: isRendered,
                  isHidden: isHidden,
                  componentTheme: appConfig.theme,
                  backgroundBoxTheme: .danger,
                  header: {
                HStack {
                    Text("Warning")
                        .font(.headline)
                    Spacer()
                }
                .padding()
            }, content: {
                VStack {
                    Text("You are about to be logged out and your data to deleted permanently. Are you sure about that? Please note that not only your personal information, but all the accounts invited to the platform will be impacted by this decission.")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
                .padding()
            }, control: {
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        Text("Proceed")
                            .font(.subheadline)
                            .bootswiftuiButton(theme: .danger, type: .regular)
                    })
                    Button(action: {}, label: {
                        Text("Cancel")
                            .font(.subheadline)
                            .bootswiftuiButton(theme: .success, type: .regular)
                    })
                }
                .padding()
            })
            .frame(height: 300)
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
        .navigationTitle("Modals")
    }
}

struct ModalPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ModalPresentationScreen()
                .preferredColorScheme(.dark)
                .environmentObject(AppConfig())
        }
    }
}
