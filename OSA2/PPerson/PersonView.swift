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
                    
                    ForEach(self.dataManager.tasks.reversed(), id: \.id) { task in
                        ZStack{
                            VStack{
                                ZStack{
                                    Image("Dino6")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(height: 80)
                                        .clipped()
                                    Image("Dino5")
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
//                                Button {
//                                            if let index = dataManager.tasks.firstIndex(where: { $0.id == task.id }) {
//                                                dataManager.tasks.remove(at: index)
//                                            }
//                                        } label: {
//                                            Image(systemName: "xmark.circle.fill")
//                                                .foregroundColor(.white)
//                                                .padding(6)
//                                                .frame( alignment: .trailing)
//                                        }
//                                        
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
                        //                dataManager.saveData()
                    }
                    .onAppear{
                        dataManager.isbarshow = true
                    }
                }.listRowSeparator(.hidden)

                .listStyle(.plain)
            .navigationBarTitle("我的任務")
            .navigationBarItems(trailing: NavigationLink(destination: AddTaskView()) {
                Image(systemName: "plus")
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
