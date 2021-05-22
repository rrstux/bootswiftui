//
//  CarouselPresentationScreen.swift
//  bootswiftui
//
//  Created by Robert Sandru on 21.05.2021.
//

import SwiftUI

struct CarouselPresentationScreen: View {
    
    @EnvironmentObject var appConfig: AppConfig
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State var selectedColorScheme: ColorScheme = .dark
    
    @State var accordionSectionData = MockData.Acordion_FAQ.list.map { mockData in
        AccordionSectionData(isCollapsed: false, header: { Text(mockData.question) }, content: { Text(mockData.answer) })
    }
    
    @State var isRendered = true
    @State var isHidden = false
    @State var isShowingIndicators = true
    @State var isAutoScrolling = true
    
    @State var activeSlide: Int = 0
    @State var carouselData = [
        CarouselData(
            isContentConstrainedToSafeZone: true,
            background: {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Image("Audi"))
                    .eraseToAnyView()
            },
            content: {
                ZStack {
                    VStack {
                        Spacer()
                        Image(systemName: "cart.circle.fill")
                            .font(.system(size: 92))
                            .foregroundColor(.white)
                        Text("Shop!")
                            .font(.system(size: 62, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                            .padding(.top)
                            .rotationEffect(.degrees(10))
                        Text("Free auto parts weekend! Come over to our marketplace. Fill the form before!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        VStack {
                            TextField("VIN", text: .constant("VWAAAZZ321312412"))
                                .font(.system(size: 18, weight: .black, design: .rounded))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.primaryLightBlue.opacity(0.2))
                                .clipShape(Capsule())
                            Button(action: {}, label: {
                                Text("Submit your VIN")
                                    .foregroundColor(Color.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red.clipShape(Capsule()))
                            })
                        }
                        Spacer()
                    }
                }
                .eraseToAnyView()
            }),
        CarouselData(
            isContentConstrainedToSafeZone: true,
            background: {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Image("LugojPasajBoldea"))
                    .eraseToAnyView()
            },
            content: {
                ZStack {
                    VStack {
                        Image(systemName: "building")
                            .font(.system(size: 92))
                            .foregroundColor(.white)
                        Text("Lugoj")
                            .font(.system(size: 62, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                            .padding(.top)
                        Text("Book tickets today. Arrive today and have fun!")
                            .font(.headline)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Button(action: {}, label: {
                            Text("Book tickets")
                                .foregroundColor(Color.white)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green.clipShape(Capsule()))
                        })
                    }
                }
                .eraseToAnyView()
            }),
        CarouselData(
            isContentConstrainedToSafeZone: true,
            background: {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                    .eraseToAnyView()
            },
            midLayer: { Rectangle().foregroundColor(.clear).eraseToAnyView() },
            content: {
                ZStack {
                    VStack {
                        Image(systemName: "swift")
                            .font(.system(size: 92))
                            .foregroundColor(.white)
                        Text("Swift.")
                            .font(.system(size: 62, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                            .padding(.top)
                        Text("More performance. More stability. More open source.")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                        
                        Button(action: {}, label: {
                            Text("Try today")
                                .foregroundColor(Color.white)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.clipShape(Capsule()))
                        })
                    }
                }
                .eraseToAnyView()
            })
    ]
    
    var body: some View {
        VStack {
            Carousel(componentTheme: appConfig.theme,
                     activeSlide: $activeSlide,
                     carouselData: carouselData,
                     isRendered: isRendered,
                     isHidden: isHidden,
                     isShowingIndicators: isShowingIndicators,
                     isAutoScrolling: isAutoScrolling)
                .frame(height: 500)
            
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
                    
                    Toggle(isOn: $isAutoScrolling, label: {
                        Label(
                            title: { Text("Is Autoscrolling") },
                            icon: { Image(systemName: "eye") }
                        )
                    })
                    Button(action: {
                        withAnimation {
                            activeSlide += 1
                        }
                    }, label: {
                        Label(
                            title: { Text("Next Slide") },
                            icon: { Image(systemName: "eye") }
                        )
                    })
                    Button(action: {
                        withAnimation {
                            activeSlide -= 1
                        }
                    }, label: {
                        Label(
                            title: { Text("Previous Slide") },
                            icon: { Image(systemName: "eye") }
                        )
                    })
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
        .navigationTitle("Carousels")
    }
    
    func collapseRandomSection(closeOthers: Bool = true) {
        if closeOthers {
            accordionSectionData = accordionSectionData.map {
                AccordionSectionData(isCollapsed: false, header: $0.header, content: $0.content)
            }
        }
        accordionSectionData[Int.random(in: accordionSectionData.indices)].isCollapsed = true
    }
    
    func collapse(all toValue: Bool = true) {
        accordionSectionData = accordionSectionData.map {
            AccordionSectionData(isCollapsed: toValue, header: $0.header, content: $0.content)
        }
    }
}

struct CarouselPresentationScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            CarouselPresentationScreen()
                .environmentObject(AppConfig())
        }
    }
}
