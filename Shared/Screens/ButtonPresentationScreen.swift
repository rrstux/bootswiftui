//
//  ButtonPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct ButtonPresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedColorScheme: ColorScheme = .dark
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(Theme.allCases.indices) { i in
                        HStack {
                            Button(action: {}, label: {
                                Label("Go to checkout", systemImage: "cart.circle.fill")
                                    .bootswiftuiButton(theme: Theme.allCases[i], type: .regular)
                            })
                            Spacer()
                            Button(action: {}, label: {
                                Label("Go to checkout", systemImage: "cart.circle.fill")
                                    .bootswiftuiButton(theme: Theme.allCases[i], type: .outline)
                            })
                        }
                    }
                }
                .padding()
            }
            .padding(1)
            
            Form {
                Section(header: Text("Themes")) {
                    Picker(selection: $selectedColorScheme, label: Text("Picker")) {
                        Text("Dark Mode").tag(ColorScheme.dark)
                        Text("Light Mode").tag(ColorScheme.light)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .frame(height: 100)
        }
        .preferredColorScheme(selectedColorScheme)
        .onAppear {
            selectedColorScheme = colorScheme
        }
        .navigationTitle("Buttons")
    }
}

struct ButtonPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ButtonPresentationScreen()
                .environmentObject(AppConfig())
        }
    }
}
