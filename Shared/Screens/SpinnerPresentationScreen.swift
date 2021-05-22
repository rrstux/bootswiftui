//
//  SpinnerPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct SpinnerPresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedColorScheme: ColorScheme = .dark
    
    @State var isLoading = false
    @State var isRendered = true
    @State var isHidden = false
    @State var isAutoScrolling = true
    
    let timer = Timer.publish(every: 4, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    ForEach(Theme.allCases.indices) { i in
                        GrowSpinner(isLoading: isLoading,
                                    componentTheme: Theme.allCases[i],
                                    isRendered: isRendered,
                                    isHidden: isHidden,
                                    isDismissable: false)
                            .frame(height: 50)
                            .padding(5)
                    }
                }
                .padding()
                HStack {
                    ForEach(Theme.allCases.indices) { i in
                        BorderSpinner(isRendered: isRendered,
                                      isHidden: isHidden,
                                      isDismissable: false,
                                      componentTheme: Theme.allCases[i],
                                      isLoading: isLoading)
                            .frame(height: 50)
                            .padding(5)
                    }
                }
                .padding()
            }
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
                    Toggle(isOn: $isLoading) {
                        Label(
                            title: { Text("Loading") },
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
                }
            }
        }
        .onReceive(timer, perform: { _ in
            appConfig.theme = Theme.allCases.randomElement()!
        })
        .preferredColorScheme(selectedColorScheme)
        .onAppear {
            selectedColorScheme = colorScheme
        }
        .navigationTitle("Spinners")
    }
}

struct SpinnerPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpinnerPresentationScreen()
                .environmentObject(AppConfig())
        }
    }
}
