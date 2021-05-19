//
//  ContentView.swift
//  Shared
//
//  Created by Robert Sandru on 16.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appConfig: AppConfig
    @State var alertHidden = false
    
    var body: some View {
        VStack {
            Button(action: {
                alertHidden.toggle()
            }, label: {
                Text("Toggle Hidden")
            })
            Alert(alertTitle: AlertMock.RomanianDisaster.title,
                  alertDescription: AlertMock.RomanianDisaster.description,
                  componentTheme: appConfig.theme,
                  componentSize: .compact,
                  isDismissable: true,
                  isShowingDivider: true,
                  isHidden: $alertHidden)
                .padding()
            Spacer()
            ThemeSwitcher(selectedTheme: $appConfig.theme)
//                .frame(maxHeight: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppConfig())
    }
}
