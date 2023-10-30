//
//  IconSetView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/24.
//

import SwiftUI

struct IconSetView: View {
    @AppStorage ("active_icon") var activeAppIcon: String = "AppIcon"
    @EnvironmentObject var dataManager:DataManager
    var body: some View {
        NavigationStack{
            Picker(selection: $activeAppIcon) {
                
                ForEach (dataManager.customIcons, id: \.self){icon in
                    Text (icon) .tag (icon)
                }
            }label: {
                
            }
        }.onChange(of: activeAppIcon) { _ in
            // MARK: Setting Alternative Icon
            UIApplication.shared.setAlternateIconName(activeAppIcon)
        }
    }
}

#Preview {
    IconSetView()
}
