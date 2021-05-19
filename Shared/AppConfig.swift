//
//  AppConfig.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import Combine

class AppConfig: ObservableObject {
    
    @Published var theme: Theme = .primary
}
