//
//  CardView.swift
//  OSA2/Users/zhangshiwei/Desktop/桌面 - 張世維的MacBook Air/my＿App_project/OSA2/OSA2/Userdata.swift
//
//  Created by 張世維 on 2023/10/24.
//

import SwiftUI
import Foundation



struct CardView: View {
    let p1 = Per(headImage: "chair_1", profileImage:"chair_1" , name: "chair_1", followerCount: 100, jobTitle: "chair_1")
    let p2 = Per(headImage: "chair_2", profileImage:"chair_2" , name: "chair_2", followerCount: 120, jobTitle: "chair_2")
    var body: some View {
        
        
        
        
        VStack{
            ZStack{
                Image(p1.headImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 80)
                    .clipped()
                Image(p1.profileImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .offset(y:40)
                    .frame(maxWidth: .infinity,alignment:.leading)
                    .padding(.horizontal)
            }.overlay(alignment: .topTrailing){
                Button{
                   
                }label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .padding(6)
                }
            }
            
            VStack(spacing: 0.0){
                Button{
                    
                }label: {
                    Text("follow")
                        .padding(.vertical,4)
                        .padding(.horizontal)
                        .overlay{
                            Capsule().stroke(lineWidth:2)
                        }
                }.frame(maxWidth: .infinity,alignment: .trailing)
                    .padding()
                
                HStack{
                    Text(p1.name)
                        .fontWeight(.bold)
                    Text(". \(p1.followerCount)")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading)
                
                Text(p1.jobTitle)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding([.leading,.bottom])
            }
        }
        .background(Color(.tertiarySystemFill))
        .cornerRadius(12)
        
        
        
        
        
        
    }
    
}




struct Per{
    let headImage:String
    let profileImage:String
    let name:String
    let followerCount:Int
    let jobTitle:String
}

#Preview {
    CardView().previewLayout(.sizeThatFits)
}
