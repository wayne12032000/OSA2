//
//  WalkthroughOnPersonAgainView.swift
//  OSA2
//
//  Created by Sheng-Fu Liang on 2024/11/22.
//

import SwiftUI

//struct WalkthroughOnPersonAgainView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}


//struct WalkthroughSlide: Identifiable {
//    let id = UUID()
//    let imageName: String
//    let description: String
//}

import SwiftUI

struct WalkthroughOnPersonAgainView: View {
    let slides: [WalkthroughSlide]
    @State private var currentIndex: Int = 0
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // Background Image (full screen)
            TabView(selection: $currentIndex) {
                ForEach(0..<slides.count, id: \.self) { index in
//                    Image(slides[index].imageName)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .edgesIgnoringSafeArea(.all) // Extend background to cover safe areas
//                        .tag(index)
                    GeometryReader { geometry in
                                            Image(slides[index].imageName)
                                                .resizable()
                                                .scaledToFit() // Maintains the aspect ratio
                                                .frame(
                                                    width: geometry.size.width - 40, // Custom horizontal padding
                                                    height: geometry.size.height - 100 // Custom vertical padding
                                                )
                                                .cornerRadius(20)
                                                .clipped()
                                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                                        }.cornerRadius(20)
                                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // Disable default page dots

            // Overlay Components
            VStack {
                Spacer()

                // Slide Description
                Text(slides[currentIndex].description)
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()

                // Page Indicator
                HStack {
                    ForEach(0..<slides.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? Color.white : Color.gray)
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 20)

                // Navigation Button (only shown on the last slide)
                if currentIndex == slides.count - 1 {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Get Started")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .transition(.opacity)
                }
            }
            .padding()
        }
        .navigationBarHidden(true) // Ensure the navigation bar doesn't interfere
        .animation(.easeInOut, value: currentIndex)
    }
}
