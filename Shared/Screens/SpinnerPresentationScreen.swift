//
//  SpinnerPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 22.05.2021.
//

import SwiftUI

struct SpinnerPresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @State var isLoading: Bool = false
    @State var isRendered: Bool = false
    @State var isHidden: Bool = false
    
    let timer = Timer.publish(every: 4, on: .main, in: .default).autoconnect()
    
    var body: some View {
        VStack {
            GrowSpinner(isLoading: isLoading,
                        componentTheme: appConfig.theme,
                        isRendered: isRendered,
                        isHidden: isHidden,
                        isDismissable: false)
            BorderSpinner(isRendered: isRendered,
                          isHidden: isHidden,
                          isDismissable: false,
                          componentTheme: appConfig.theme,
                          isLoading: isLoading)
            Button(action: {
                isLoading.toggle()
            }, label: {
                Text("Button")
            })
            ThemeSwitcher(selectedTheme: $appConfig.theme)
        }
        .onReceive(timer, perform: { _ in
            appConfig.theme = Theme.allCases.randomElement()!
        })
        .navigationTitle("Spinners")
    }
}

struct SpinnerPresentationScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpinnerPresentationScreen()
        }
    }
}
