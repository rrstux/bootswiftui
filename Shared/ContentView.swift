//
//  ContentView.swift
//  Shared
//
//  Created by Robert Sandru on 16.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var theme: Theme
    
    var body: some View {
        Text("Hello, world!")
            .foregroundColor(theme.config.text)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(theme: .danger)
    }
}
