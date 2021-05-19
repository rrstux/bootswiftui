//
//  Alert.swift
//  bootswiftui
//
//  Created by Robert Sandru on 19.05.2021.
//

import SwiftUI

struct Alert: View, Component {
    
    fileprivate enum AlertMode {
        case regular // Regular alert with title and description
        case noTitle // Just the description without bold.
    }
    
    fileprivate var alertMode: AlertMode {
        if alertTitle == nil { return .noTitle }
        return .regular
    }
    
    var alertTitle: String?
    var alertDescription: String
    
    var componentTheme: Theme
    
    var isDismissable: Bool
    
    // MARK: Bindings
    
    @Binding var isRendered: Bool
    @Binding var isHidden: Bool
    
    var body: some View {
        if !isRendered {
            EmptyView()
        } else {
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(componentTheme.config.background)
                    .boxMode(theme: componentTheme)
                switch alertMode {
                case .regular: regularAlert.padding()
                case .noTitle: noTitleAlert.padding()
                }
            }
            .opacity(isHidden ? 0 : 1)
        }
    }
    
    // MARK: AlertMode: Regular
    
    fileprivate var regularAlert: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
                Text(alertTitle ?? "")
                    .font(.headline)
                    .foregroundColor(componentTheme.config.text)
                if isDismissable {
                    Spacer()
                    dismissButton()
                }
            }
            Divider()
            ScrollView {
                Text(alertDescription)
                    .font(.subheadline)
                    .foregroundColor(componentTheme.config.text)
            }
        }
    }
    
    // MARK: AlertMode: No Title
    
    private var noTitleAlert: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                ScrollView {
                    Text(alertDescription)
                        .font(.subheadline)
                        .foregroundColor(componentTheme.config.text)
                }
                Spacer()
                if isDismissable {
                    dismissButton()
                }
            }
        }
    }
    
    // MARK: Helpers
    
    fileprivate func dismissButton() -> some View {
        Button(action: {
            isRendered = false
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(componentTheme.config.ternary)
        })
    }
}

struct Alert_Previews: PreviewProvider {
    
    static var previews: some View {
        Alert(alertTitle: AlertMock.RomanianDisaster.title,
              alertDescription: AlertMock.RomanianDisaster.description,
              componentTheme: .danger,
              isDismissable: true,
              isRendered: .constant(true),
              isHidden: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
