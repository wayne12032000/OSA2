//
//  SettingView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//

import SwiftUI


struct SettingView: View {
    // MARK: For Storing Currently Active App Icon
    
    @EnvironmentObject var dataManager:DataManager
    var body: some View {
       
            VStack{//a
                ZStack{
                    Image("chair_1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()
                    Image("my_circle_1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 150)
                        .offset(y:130)
                        .frame(maxWidth: .infinity,alignment:.center)
                        .padding(.horizontal)
//                        .clipShape(Circle())
                }
                Text("$ : 100     ")
                    .frame(maxWidth: .infinity,alignment: .trailing)
                    .padding([.trailing,.top])
                Spacer()
                
                VStack(spacing: 0.0){
                    
                    HStack{
                        NavigationLink(destination: HistoryView()) {
                            Image(systemName: "calendar")
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                        }.frame(maxWidth: .infinity,alignment: .center)
                            .padding()
                        NavigationLink(destination: IconSetView()) {
                            Image(systemName: "gearshape")
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                        }.frame(maxWidth: .infinity,alignment: .center)
                            .padding()
                      
                    }
                    
                    
                    
                }.padding(.horizontal)
                    .frame(alignment: .bottom)
                Spacer()
                
                
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .cornerRadius(12)
            .edgesIgnoringSafeArea(.top)
        
    
        
        


        
        
        
        
        
        
        
        
        
        
    }
}
#Preview {
    SettingView()
}


//
//NavigationStack{
//    Picker(selection: $activeAppIcon) {
//        let customIcons: [String] = ["AppIcon", "AppIcon 1", "AppIcon 2", "AppIcon 3"]
//        ForEach (customIcons, id: \.self){icon in
//            Text (icon) .tag (icon)
//        }
//    }label: {
//        
//    }
//}.onChange(of: activeAppIcon) { _ in
//    // MARK: Setting Alternative Icon
//    UIApplication.shared.setAlternateIconName(activeAppIcon)
//}
