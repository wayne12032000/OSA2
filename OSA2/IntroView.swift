//
//  IntroView.swift
//  OSA2
//
//  Created by 張世維 on 2024/2/20.
//

import SwiftUI




struct IntroView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("Icon_black") // Replace "introBackgroundImage" with the name of your image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: min(geometry.size.width, geometry.size.height) * 0.5) // Adjust size here
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Center the image
                
                VStack {
                    Spacer()
                    Spacer()
                    Text("OSA")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        
                    Text("Designed by NCBCI in NCKU. ver 1.0")
                                            .font(.title3)
                                            .foregroundColor(.black)
                                            .padding()
                    Spacer()
                    
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 5) // Center the image
                Spacer()
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.white.opacity(0.8)) // Overlay a semi-transparent background
    }
}


#Preview {
    IntroView()
}
