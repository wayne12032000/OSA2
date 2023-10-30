//
//  ContentView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .book
    @EnvironmentObject var dataManager:DataManager
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    if tabSelected == Tab.book{
                        
                        LobbyView()
                    }else if tabSelected == Tab.heart{
                        //                    Text("person")
                        PersonView()
                    }else if tabSelected == Tab.person{
                        
                        SettingView()
                    }
                }
                if dataManager.isbarshow {
                                VStack {
                                    Spacer()
                                    CustomTabBar(selectedTab: $tabSelected).frame( alignment: .bottom)
                                }
                            }
                
            }.frame(maxHeight: .infinity, alignment: .bottom)
            
//            Spacer()
//            
//            
//            CustomTabBar(selectedTab: $tabSelected).frame( alignment: .bottom)
            
        }
    }
}

#Preview {
    ContentView()
}
