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
    @State private var isAlertPresented = false
    @State private var isAlertPresented1 = false
    var iconInStore:[iconinfo] = [iconinfo(id: "Icon_black",iconName: "AppIcon", cost: 0, OwnOrNot: true),
                                  iconinfo(id: "Icon_blue",iconName: "AppIcon 1", cost: 200, OwnOrNot: false),
                                  iconinfo(id: "Icon_purple", iconName: "AppIcon 2",cost: 1000, OwnOrNot: false),
                                  iconinfo(id: "Icon_gold",iconName: "AppIcon 3", cost: 5000, OwnOrNot: false)]
    var body: some View {
//        NavigationStack{
//            Picker(selection: $activeAppIcon) {
//                
//                ForEach (dataManager.customIcons, id: \.self){icon in
//                    Text (icon) .tag (icon)
//                }
//            }label: {
//                
//            }
//        }.onChange(of: activeAppIcon) { _ in
//            // MARK: Setting Alternative Icon
//            UIApplication.shared.setAlternateIconName(activeAppIcon)
//        }
//        
        
        
        Text("歡迎來到商店").font(.largeTitle)
        HStack {
            Image("S__24862787")
                .resizable()
                .scaledToFit()
                .frame(height: 25) // Ensure this height matches the size of your text

            Text(": \(dataManager.credit)")
//            Button{
//                dataManager.credit = 10000
//                dataManager.iconInStore[0].OwnOrNot = false
//                dataManager.iconInStore[1].OwnOrNot = false
//                dataManager.iconInStore[2].OwnOrNot = false
//                dataManager.iconInStore[3].OwnOrNot = false
//            }label: {
//               Text("plussss")
//            }
//            Text(": 10000")
                // .padding(.top) // If you need padding on top, you can uncomment this line
        }
        .padding(.horizontal) // Add horizontal padding if needed
        .frame(maxWidth: .infinity) // This will center the HStack in the parent view
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("兌換成功！"),
                message: Text("成功更換嘍！"),
                dismissButton: .default(Text("確定")){
                    // Dismiss the current view when the "確定" button is pressed
                    
                }
            )
        }
        .alert(isPresented: $isAlertPresented1) {
            Alert(
                title: Text("兌換失敗！"),
                message: Text("您的代幣不夠喔～"),
                dismissButton: .default(Text("確定")){
                    // Dismiss the current view when the "確定" button is pressed
                    
                }
            )
        }
        List {
            ForEach(dataManager.iconInStore, id: \.id) { ii in
                HStack {
                    Image(ii.id)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 80)
                        .padding(.horizontal)

                    Spacer()

                    Button {
                        if ii.OwnOrNot {
                                // If the icon is owned, set it as the app's icon
                            UIApplication.shared.setAlternateIconName(ii.iconName)
                        } else {
                                // If the icon is not owned, initiate purchase process
                                // Assuming you have a function to handle purchase
                                if dataManager.credit>=ii.cost{
                                    dataManager.credit-=ii.cost
                                    ii.OwnOrNot = true
                                    UIApplication.shared.setAlternateIconName(ii.iconName)
                                    isAlertPresented.toggle()
                                    
                                }else{
                                    isAlertPresented1.toggle()
                                }
                                
                        }
                    } label: {
                        if ii.OwnOrNot{
                            Text("使用")
                                .padding(.vertical, 4)
                                .padding(.horizontal)
                                .overlay(
                                    Capsule().stroke(lineWidth: 2)
                                )
                        }else{
                            HStack {
                                Image("S__24862787")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 25) // Ensure this height matches the size of your text

                    //            Text(": \(dataManager.credit)")
                                Text(" \(ii.cost)")
                                    // .padding(.top) // If you need padding on top, you can uncomment this line
                            }
                                .padding(.vertical, 4)
                                .padding(.horizontal)
                                .overlay(
                                    Capsule().stroke(lineWidth: 2)
                                )
                        }
                        
                    }
                    .padding()
                    
                }
                .padding() // Apply padding to the HStack
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white)) // Apply background to the HStack
                .listRowInsets(EdgeInsets()) // Remove default insets
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle()) // Remove default List styling

        
        Spacer()
    }
    
    
    
}

#Preview {
    IconSetView()
}
