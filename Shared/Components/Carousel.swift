//
//  Carousel.swift
//  bootswiftui
//
//  Created by Robert Sandru on 21.05.2021.
//

import SwiftUI

struct Carousel: View {
    
    @State private var activeSlide: Int = 2
    var body: some View {
        VStack {
            Text("lol")
            ZStack {
                TabView(selection: $activeSlide) {
                    ZStack {
                        Rectangle().foregroundColor(.red)
                        Text("Slide 1")
                    }
                    .tag(0)
                    ZStack {
                        Rectangle().foregroundColor(.blue)
                        Text("Slide 2")
                    }
                    .tag(1)
                    Text("Slide 3")
                        .tag(2)
                }
                HStack {
                    Button(action: {
                        withAnimation {
                            activeSlide -= 1
                        }
                    }, label: {
                        Text("Previous Slide").border(Color.black)
                    })
                    Spacer()
                    Button(action: {
                        withAnimation {
                            activeSlide += 1
                        }
                    }, label: {
                        Text("Next Slide").border(Color.black)
                    })
                }
            }
            .frame(height: 400)
            .tabViewStyle(PageTabViewStyle())
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel()
    }
}
