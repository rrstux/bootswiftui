//
//  Modal.swift
//  bootswiftui
//
//  Created by Robert Sandru on 24.05.2021.
//

import SwiftUI

struct Modal<Header, Content, Control>: View, Component where Header : View,
                                                              Content : View,
                                                              Control: View {
    var isRendered: Bool
    var isHidden: Bool = false
    var isDismissable: Bool = true
    
    var componentTheme: Theme = .primary
    var backgroundBoxTheme: Theme = .white
    
    var header: Header?
    var content: Content?
    var control: Control?
    
    @EnvironmentObject var appConfig: AppConfig
    
    var body: some View {
        if isRendered {
            ZStack {
                Rectangle()
                    .boxMode(theme: backgroundBoxTheme, type: .regular)
                    .layoutPriority(-1)
                VStack(alignment: .leading, spacing: 0) {
                    header
                    Divider()
                    ScrollView {
                        content
                    }
                    control
                }
            }
            .foregroundColor(componentTheme.config.text)
            .opacity(isHidden ? 0 : 1)
        } else {
            EmptyView()
        }
    }
}

extension Modal {
    
    // MARK: Base Initializer
    
    init(isRendered: Bool = true,
         isHidden: Bool = false,
         isDismissable: Bool = false,
         componentTheme: Theme = .primary,
         backgroundBoxTheme: Theme = .white,
         @ViewBuilder header: () -> Header?,
         @ViewBuilder content: () -> Content?,
         @ViewBuilder control: () -> Control?) {
        self.isRendered = isRendered
        self.isHidden = isHidden
        self.isDismissable = isDismissable
        self.componentTheme = componentTheme
        self.backgroundBoxTheme = backgroundBoxTheme
        self.header = header()
        self.content = content()
        self.control = control()
    }
}

struct Modal_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            Modal(header: {
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
            .frame(width: 300, height: 250)
        }
    }
}
