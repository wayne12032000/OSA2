//
//  LobbyTaskDtView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/24.
//



import SwiftUI

struct LobbyTaskDtView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dataManager: DataManager
    let task:Task
    let tid:String
    @State private var refreshID = UUID()
        
    var body: some View {
        
            ZStack {
                Color("Bg")
                ScrollView  {
                    //            Product Image
                    
                        Image("Dino5")
                            .resizable()
                            .aspectRatio(1,contentMode: .fit)
                            .edgesIgnoringSafeArea(.top)
                    
                    DesView(task:task,tid:tid)
                }
                .edgesIgnoringSafeArea(.top)
                
                HStack {
                    
                    Spacer()
                    Button(action: {
                        dataManager.tasks.append(task)
                        refreshID = UUID()
                    }) {
                        Text("Add to Favorite")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                            .padding()
                            .padding(.horizontal, 8)
                            .background(Color.white)
                            .cornerRadius(10.0)
                    }
                }
                .padding()
                .padding(.horizontal)
                .background(Color("Primary"))
                .cornerRadius(60.0, corners: .topLeft)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .edgesIgnoringSafeArea(.bottom)
                .id(refreshID)
                .onAppear{
                    dataManager.isbarshow = false
                }
            }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: {
                presentationMode.wrappedValue.dismiss()
                dataManager.isbarshow = true
            }))
        }
    }



    


   

    struct DesView: View {
        @EnvironmentObject var dataManager: DataManager
        let task:Task
        let tid:String
        @State private var refreshID = UUID()
        var body: some View {
            VStack (alignment: .leading) {
                //                Title
                if let index = dataManager.recommendTasks.firstIndex(where: { $0.id == tid }) {
                    Text("\(dataManager.recommendTasks[index].id)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                }
               
                
                Text("Description")
                    .fontWeight(.medium)
                    .padding(.vertical, 8)
                Text("Too good to see you here, let's go have a wonderful life!")
                    .lineSpacing(8.0)
                    .opacity(0.6)
                
                //                Info
                HStack (alignment: .top) {
                    
                    
                    
                    VStack (alignment: .leading) {
                        
                        if let index = dataManager.recommendTasks.firstIndex(where: { $0.id == tid }) {
                            Text("Total")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Text("Total iter: \(dataManager.recommendTasks[index].Total_iter)").opacity(0.6)
                            
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical)
                VStack (alignment: .leading) {
                    
                    Text("Task review")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        
                    
//                        if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                            ForEach(task.taslitems, id: \.id) { task in
                                Text("\(task.id)").opacity(0.6)
                            }
//                        }
                    
                } .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
            .padding(.top)
            .background(Color("Bg"))
            .cornerRadius(30, corners: [.topLeft, .topRight])
            .offset(x: 0, y: -30.0)
            
        }
    }


  
