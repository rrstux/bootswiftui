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
    var componentSize: ComponentSize = .standard
    
    var isDismissable: Bool
    var isShowingDivider: Bool = true
    
    // MARK: Bindings
    
    @Binding var isHidden: Bool
    
    var body: some View {
        if isHidden {
            EmptyView()
        } else {
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(componentTheme.config.background)
                    .boxMode(theme: componentTheme)
                    .layoutPriority(-1)
                switch alertMode {
                case .regular: regularAlert.padding()
                case .noTitle: noTitleAlert.padding()
                }
            }
        }
    }
    
    // MARK: AlertMode: Regular
    
    fileprivate var regularAlert: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(alertTitle ?? "")
                    .font(.headline)
                    .foregroundColor(componentTheme.config.text)
                if isDismissable {
                    Spacer()
                    dismissButton()
                }
            }
            Divider()
            Text(alertDescription)
                .font(.subheadline)
                .foregroundColor(componentTheme.config.text)
        }
    }
    
    // MARK: AlertMode: No Title
    
    private var noTitleAlert: some View {
        Text("no Title")
    }
    
    // MARK: Helpers
    
    fileprivate func dismissButton() -> some View {
        Button(action: {
            isHidden = true
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
              componentSize: .compact,
              isDismissable: true,
              isShowingDivider: true,
              isHidden: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}

extension Alert {
    
    func titleSize() -> Font {
        switch componentSize {
        case .compact: return .title
        case .standard: return .headline
        }
    }
}
