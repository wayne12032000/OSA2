//
//  LobbyView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/20.
//

import SwiftUI

struct LobbyView:View {
        @EnvironmentObject var dataManager:DataManager
        var body: some View {
                    List{
                        
                        ForEach(self.dataManager.recommendTasks, id: \.id) { task in
                            ZStack{
                                VStack{
                                    ZStack{
                                        Image("Dino5")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 80)
                                            .clipped()
                                        Image("Dino6")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 80)
                                            .offset(y:40)
                                            .frame(maxWidth: .infinity,alignment:.leading)
                                            .padding(.horizontal)
                                    }
                                    VStack(spacing: 0.0){
                                        Button{
                                            
                                        }label: {
                                            Text("Detail")
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
                                        
                                        Text("10 minutes")
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                            .padding([.leading,.bottom])
                                    }
 
    //
                                }
                                .background(Color(.tertiarySystemFill))
                                .cornerRadius(12)
                                
                                
                                NavigationLink(destination: LobbyTaskDtView(task:task,tid:task.id)) {
                                    EmptyView()
                                }.buttonStyle(PlainButtonStyle())

                                    .listRowSeparator(.hidden)
                                    .foregroundColor(.black)
                                
                            }
                            .listRowSeparator(.hidden)
                        }
                        .onDelete { indexSet in
                            dataManager.tasks.remove(atOffsets: (indexSet))
                            //                dataManager.saveData()
                        }
                        .onAppear{
                            dataManager.isbarshow = true
                        }
                    }.listRowSeparator(.hidden)

                    .listStyle(.plain)
                .navigationBarTitle("快速體驗")
               
            
            
        }
    }
     
            
            
       


    
