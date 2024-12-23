//
//  WalkthroughView.swift
//  OSA2
//
//  Created by Sheng-Fu Liang on 2024/11/22.
//

import SwiftUI
import SwiftUI

struct WalkthroughSlide: Identifiable {
    let id = UUID()
    let imageName: String
    let description: String
}
//
//struct WalkthroughView: View {
//    let slides: [WalkthroughSlide]
//    @State private var currentIndex: Int = 0
//    @State private var navigateToMainApp = false
//    @StateObject private var dataManager = DataManager()
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Background Image
//                Image(slides[currentIndex].imageName)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .edgesIgnoringSafeArea(.all)
//
//                // Content Overlay
//                VStack(spacing: 20) {
//                    Spacer()
//
//                    // Slide Description
//                    Text(slides[currentIndex].description)
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.center)
//                        .padding()
//
//                    Spacer()
//
//                    // Page Indicator
//                    HStack {
//                        ForEach(0..<slides.count, id: \.self) { index in
//                            Circle()
//                                .fill(index == currentIndex ? Color.white : Color.gray)
//                                .frame(width: 8, height: 8)
//                        }
//                    }
//                    .padding()
//
//                    // Navigation Button
//                    if currentIndex < slides.count - 1 {
//                        Button(action: {
//                            currentIndex += 1
//                        }) {
//                            Text("Next")
//                                .foregroundColor(.white)
//                                .font(.headline)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                                .padding(.horizontal)
//                        }
//                    } else {
//                        NavigationLink(
//                            destination: ContentView().environmentObject(dataManager),
//                            isActive: $navigateToMainApp
//                        ) {
//                            Button(action: {
//                                navigateToMainApp = true
//                            }) {
//                                Text("Get Started")
//                                    .foregroundColor(.white)
//                                    .font(.headline)
//                                    .padding()
//                                    .frame(maxWidth: .infinity)
//                                    .background(Color.green)
//                                    .cornerRadius(10)
//                                    .padding(.horizontal)
//                            }
//                        }
//                    }
//                }
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [.black.opacity(0.8), .clear]),
//                        startPoint: .bottom,
//                        endPoint: .top
//                    )
//                    .edgesIgnoringSafeArea(.bottom)
//                )
//            }
//            .navigationBarHidden(true) // Hides the navigation bar
//        }
//    }
//}
//
//
//
////
////  WalkthroughOnPersonAgainView.swift
////  OSA2
////
////  Created by Sheng-Fu Liang on 2024/11/22.
////

struct WalkthroughView: View {
    let slides: [WalkthroughSlide]
    @State private var currentIndex: Int = 0
    @State private var navigateToMainApp = false
    @StateObject private var dataManager = DataManager()

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image (full screen)
                TabView(selection: $currentIndex) {
                    ForEach(0..<slides.count, id: \.self) { index in
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
                                            }
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
                        NavigationLink(
                            destination: ContentView()
                                .environmentObject(dataManager),
                            isActive: $navigateToMainApp
                        ) {
                            EmptyView() // NavigationLink needs a view but we handle it through the button
                        }

                        Button(action: {
                            navigateToMainApp = true
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
                        .transition(.opacity) // Smooth button appearance
                    }
                }
                .padding()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true) // Ensure the navigation bar doesn't interfere
            .animation(.easeInOut, value: currentIndex)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
