//
//  Carousel.swift
//  bootswiftui
//
//  Created by Robert Sandru on 21.05.2021.
//

import SwiftUI
import Combine

struct CarouselData: Identifiable {
    
    var id = UUID()
    var isContentConstrainedToSafeZone = true
    
    var background: () -> AnyView
    var midLayer: () -> AnyView = { Rectangle().opacity(0.4).eraseToAnyView() }
    var content: () -> AnyView
}

struct Carousel<Content>: View, Component where Content : View {
    
    var componentTheme: Theme
    
    @Binding var activeSlide: Int
    
    @Binding var carouselData: [CarouselData]
    
    @ViewBuilder let leftControlView: Content?
    @ViewBuilder let rightControlView: Content?
    
    @Binding var isRendered: Bool
    @Binding var isHidden: Bool
    @Binding var isShowingIndicators: Bool
    @Binding var isAutoScrolling: Bool
    
    // MARK: Safe Zone Calculator
    
    @State private var leftControlViewSize: CGSize = .zero
    @State private var rightControlViewSize: CGSize = .zero
    private let leftControlViewWidthPercent: CGFloat = 0.15
    private let rightControlViewWidthPercent: CGFloat = 0.15
    
    private var safeZone: EdgeInsets {
        .init(top: 0,
              leading: leftControlViewSize.width,
              bottom: isShowingIndicators ? 50 : 0,
              trailing: rightControlViewSize.width)
    }
    
    // MARK: Slide Scrolling
    
    private var isFirstSlide: Bool {
        return activeSlide == 0
    }
    
    private var isLastSlide: Bool {
        return activeSlide == carouselData.count-1
    }
    
    let timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
    
    internal var isDismissable: Bool = false
    
    init(
        componentTheme: Theme,
        activeSlide: Binding<Int>,
        carouselData: Binding<[CarouselData]>,
        isRendered: Binding<Bool>,
        isHidden: Binding<Bool>,
        isShowingIndicators: Binding<Bool>,
        isAutoScrolling: Binding<Bool>,
        @ViewBuilder leftControlView: () -> Content?,
        @ViewBuilder rightControlView: () -> Content?) {
        self.componentTheme = componentTheme
        self._activeSlide = activeSlide
        self._carouselData = carouselData
        self._isRendered = isRendered
        self._isHidden = isHidden
        self._isShowingIndicators = isShowingIndicators
        self._isAutoScrolling = isAutoScrolling
        self.leftControlView = leftControlView()
        self.rightControlView = rightControlView()
    }
    
    init(
        componentTheme: Theme,
        activeSlide: Binding<Int>,
        carouselData: Binding<[CarouselData]>,
        isRendered: Binding<Bool> = .constant(true),
        isHidden: Binding<Bool> = .constant(false),
        isShowingIndicators: Binding<Bool> = .constant(true),
        isAutoScrolling: Binding<Bool> = .constant(true)) where Content == AnyView {
        self.init(
            componentTheme: componentTheme,
            activeSlide: activeSlide,
            carouselData: carouselData,
            isRendered: isRendered,
            isHidden: isHidden,
            isShowingIndicators: isShowingIndicators,
            isAutoScrolling: isAutoScrolling) {
            AnyView(
                Image(systemName: "chevron.left")
                    .font(.title)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(componentTheme.config.text))
        } rightControlView: {
            AnyView(
                Image(systemName: "chevron.right")
                    .font(.title)
                    .frame(maxHeight: .infinity)
                    .foregroundColor(componentTheme.config.text))
        }
    }
    
    @State var dumpTest: String = ""
    var body: some View {
        GeometryReader { reader in
            ZStack {
                TabView(selection: $activeSlide) {
                    ForEach(carouselData.indices) { i in
                        ZStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .overlay(carouselData[i].background())
                            carouselData[i].midLayer()
                            carouselData[i]
                                .content()
                                .padding(carouselData[i].isContentConstrainedToSafeZone ? safeZone : .init())
                        }
                        .clipped()
                        .id(i)
                    }
                }
                carouselControls()
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isShowingIndicators ? .always : .never))
        .onReceive(timer, perform: { t in
            withAnimation {
                increaseActiveSlide(shouldInfinityScroll: true)
            }
        })
    }
    
    fileprivate func carouselControls() -> some View {
        return GeometryReader { reader in
            HStack {
                Button(action: {
                    withAnimation {
                        decreaseActiveSlide()
                    }
                }, label: {
                    leftControlView
                        .frame(width: reader.size.width * leftControlViewWidthPercent)
                        .opacity(isFirstSlide ? 0 : 1)
                })
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        increaseActiveSlide()
                    }
                }, label: {
                    rightControlView
                        .frame(width: reader.size.width * rightControlViewWidthPercent)
                        .opacity(isLastSlide ? 0 : 1)
                })
            }
            .onAppear {
                leftControlViewSize = CGSize(width: reader.size.width*leftControlViewWidthPercent, height: reader.size.height)
                rightControlViewSize = CGSize(width: reader.size.width*rightControlViewWidthPercent, height: reader.size.height)
            }
        }
    }
    
    fileprivate func decreaseActiveSlide() {
        if isFirstSlide { return }
        activeSlide -= 1
    }
    
    fileprivate func increaseActiveSlide(shouldInfinityScroll: Bool = false) {
        if !shouldInfinityScroll {
            if isLastSlide { return }
            activeSlide += 1
        } else {
            if isLastSlide {
                activeSlide = 0
            } else {
                activeSlide += 1
            }
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    
    @State static var carouselData = [
        
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
                        Text("Autoparts")
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
    
    @State static var activeSlide: Int = 0
    
    static var previews: some View {
        Carousel(componentTheme: .warning,
                 activeSlide: $activeSlide,
                 carouselData: $carouselData,
                 isRendered: .constant(true),
                 isHidden: .constant(false),
                 isShowingIndicators: .constant(true))
            .frame(height: 500)
    }
}
