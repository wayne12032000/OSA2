//
//  PersonView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//

import SwiftUI

struct PersonView: View {
    @EnvironmentObject var dataManager:DataManager
    var body: some View {
                List{
                    
                    ForEach(self.dataManager.tasks, id: \.id) { task in
                        ZStack{
                            VStack{
                                ZStack{
                                    if let image = UIImage(named: task.imageuse) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(height: 80)
                                                .clipped()
                                            Image(uiImage: image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 80)
                                                .offset(y:40)
                                                .frame(maxWidth: .infinity,alignment:.leading)
                                                .padding(.horizontal)
                                        } else {
                                            Image("伸展")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(height: 80)
                                                .clipped()
                                            Image("伸展")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 80)
                                                .offset(y:40)
                                                .frame(maxWidth: .infinity,alignment:.leading)
                                                .padding(.horizontal)
                                        }
                                        
//                                    Image("Dino6")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(height: 80)
//                                        .offset(y:40)
//                                        .frame(maxWidth: .infinity,alignment:.leading)
//                                        .padding(.horizontal)
                                }
                                VStack(spacing: 0.0){
                                    Button{
                                        
                                    }label: {
                                        Text("查看內容")
                                            .padding(.vertical,4)
                                            .padding(.horizontal)
                                            .overlay{
                                                Capsule().stroke(lineWidth:2)
                                            }
                                    }.frame(maxWidth: .infinity,alignment: .trailing)
                                        .padding()
                                    
                                    HStack{
                                        Text(task.id)
                                            .fontWeight(.bold)
                                       
                                    }
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.leading)
                                    
                                    Text(dataManager.secondsToMinutesAndSeconds(seconds: task.totalTime))
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding([.leading,.bottom])
                                }
                                        
                            }
                            .background(Color(.tertiarySystemFill))
                            .cornerRadius(12)
                            
                            
                            NavigationLink(destination: TaskDtView(task:task,tid:task.id)) {
                                EmptyView()
                            }.buttonStyle(PlainButtonStyle())

                                .listRowSeparator(.hidden)
                                .foregroundColor(.black)
                            
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete { indexSet in
                        dataManager.tasks.remove(atOffsets: indexSet)
                     
                    }
                    .onAppear{
                        dataManager.isbarshow = true
                    }
                }.listRowSeparator(.hidden)

                .listStyle(.plain)
            .navigationBarTitle("我的課程")
            .navigationBarItems(trailing: HStack {
                        // First Navigation Item
                // Second Navigation Item
                NavigationLink(destination: WalkthroughOnPersonAgainView(
                    slides: [
                       
                        WalkthroughSlide(imageName: "s1", description: ""),
                        WalkthroughSlide(imageName: "s2", description: ""),
                        WalkthroughSlide(imageName: "s3", description: ""),
                        
                        WalkthroughSlide(imageName: "s4", description: ""),
                        WalkthroughSlide(imageName: "s5", description: ""),
                        WalkthroughSlide(imageName: "s6", description: ""),
                        
                        WalkthroughSlide(imageName: "s7", description: ""),
                        WalkthroughSlide(imageName: "s8", description: ""),
                        WalkthroughSlide(imageName: "s9", description: ""),
                        
                        WalkthroughSlide(imageName: "s10", description: ""),
                        WalkthroughSlide(imageName: "s11", description: ""),
                        WalkthroughSlide(imageName: "s12", description: ""),
                        
                        WalkthroughSlide(imageName: "s13", description: ""),
                        WalkthroughSlide(imageName: "s14", description: ""),
                        WalkthroughSlide(imageName: "s15", description: ""),
                        
                        WalkthroughSlide(imageName: "s16", description: ""),
                        WalkthroughSlide(imageName: "s17", description: ""),
                        WalkthroughSlide(imageName: "s18", description: ""),
                        
                        WalkthroughSlide(imageName: "s19", description: ""),
                        WalkthroughSlide(imageName: "s20", description: "")
                    ]
                    
                )) {
//                            Image(systemName: "plus")
                    Text("教學")
                }
                        
                // Second Navigation Item
                NavigationLink(destination: AddTaskView()) {
//                            Image(systemName: "plus")
                    Text("新增")
                }
            })
        
        
    }
}
struct ProductCardView: View {
    let image: Image
    let size: CGFloat
    let tid:String
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height:450)
                .cornerRadius(20.0)
                .clipped()
                
            Text("\(tid)").font(.title3).fontWeight(.bold)
            
            
        }
        .frame(width: size,height: 500)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
        
    }
}

        
        
        
   


#Preview {
    PersonView()
}
