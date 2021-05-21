//
//  Carousel.swift
//  bootswiftui
//
//  Created by Robert Sandru on 21.05.2021.
//

import SwiftUI

struct CarouselData: Identifiable {
    
    var id = UUID()
    
    var background: () -> AnyView
    var midLayer: () -> AnyView
    var content: () -> AnyView
}

struct Carousel<Content>: View, Component where Content : View {
    
    var componentTheme: Theme
    
    @State private var activeSlide: Int = 0
    
    @Binding var carouselData: [CarouselData]
    
    @ViewBuilder let leftControlView: Content?
    @ViewBuilder let rightControlView: Content?
    
    @Binding var isRendered: Bool
    @Binding var isHidden: Bool
    
    internal var isDismissable: Bool = false
    
    init(
        componentTheme: Theme,
        carouselData: Binding<[CarouselData]>,
        isRendered: Binding<Bool>,
        isHidden: Binding<Bool>,
        @ViewBuilder leftControlView: () -> Content?,
        @ViewBuilder rightControlView: () -> Content?) {
        self.componentTheme = componentTheme
        self._carouselData = carouselData
        self._isRendered = isRendered
        self._isHidden = isHidden
        self.leftControlView = leftControlView()
        self.rightControlView = rightControlView()
    }
    
    init(
        componentTheme: Theme,
        carouselData: Binding<[CarouselData]>,
        isRendered: Binding<Bool>,
        isHidden: Binding<Bool>) where Content == AnyView {
        self.init(
            componentTheme: componentTheme,
            carouselData: carouselData,
            isRendered: isRendered,
            isHidden: isHidden) {
            AnyView(
                Image(systemName: "chevron.left")
                    .font(.title)
                    .padding(.leading, 20)
                    .padding(.trailing, 40)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(componentTheme.config.text))
        } rightControlView: {
            AnyView(
                Image(systemName: "chevron.right")
                    .font(.title)
                    .padding(.leading, 40)
                    .padding(.trailing, 20)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(componentTheme.config.text))
        }
    }
    
    var body: some View {
        VStack {
            Text("lol")
            ZStack {
                TabView(selection: $activeSlide) {
                    ForEach(carouselData.indices) { i in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .overlay(carouselData[i].background())
                            carouselData[i].midLayer()
                            carouselData[i].content()
                        }
                        .clipped()
                        .id(i)
                    }
                }
                carouselControls()
            }
            .frame(height: 400)
            .padding()
            .tabViewStyle(PageTabViewStyle())
        }
    }
    
    fileprivate func carouselControls() -> some View {
        return HStack {
            Button(action: {
                withAnimation {
                    activeSlide -= 1
                }
            }, label: {
                leftControlView
            })
            
            Spacer()
            Button(action: {
                withAnimation {
                    activeSlide += 1
                }
            }, label: {
                rightControlView
            })
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    
    @State static var carouselData = [
        CarouselData(background: {
            Rectangle()
                .foregroundColor(.clear)
                .overlay(            Image(systemName: "swift")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(.white))
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                           startPoint: .leading,
                                           endPoint: .bottom))
                //                .background(Color.red)
                .eraseToAnyView()
        },
        midLayer: {
            Rectangle()
                .opacity(0.4)
                .eraseToAnyView()
        },
        content: {
            HStack {
                VStack {
                    Text("First Slide Text")
                        .foregroundColor(.white)
                    Spacer()
                }
                Spacer()
            }
            .eraseToAnyView()
        }),
        CarouselData(background: {
            Rectangle()
                .eraseToAnyView()
        },
        midLayer: {
            Text("Lol")
                .eraseToAnyView()
        },
        content: {
            HStack {
                Text("Second slide text")
                Text("much wow!")
            }
            .foregroundColor(.white)
            .eraseToAnyView()
        })
    ]
    static var previews: some View {
        Carousel(componentTheme: .primary,
                 carouselData: $carouselData,
                 isRendered: .constant(true),
                 isHidden: .constant(false))
    }
}
