//
//  OSA2App.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/20.
//

import SwiftUI

@main
struct OSA2App: App {
    @StateObject private var dataManager = DataManager()
    var body: some Scene {
        WindowGroup {
            
                ContentView().environmentObject(dataManager)
            
           
        }
    }
}
