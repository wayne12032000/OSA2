//
//  CustomTabBar.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//


import SwiftUI

//enum Tab: String, CaseIterable {
////    case book
//    case heart
//    case person
//}
enum Tab: CaseIterable {
    case lessons
    case settings

    var displayText: String {
        switch self {
        case .lessons:
            return "課程"
        case .settings:
            return "設定"
        }
    }

    var tabColor: Color {
        switch self {
        case .lessons:
            return .purple
        case .settings:
            return .orange
        }
    }
}
struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Spacer()
                    Text(tab.displayText)
                        .font(.system(size: 20))
                        .foregroundColor(selectedTab == tab ? tab.tabColor : .gray)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(height: 60)
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding()
        }
    }
}
