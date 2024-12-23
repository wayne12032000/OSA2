//
//  TaskDtView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/22.
//

import SwiftUI

struct TaskDtView: View {
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
                    
                        Image("Dino6")
                            .resizable()
                            .aspectRatio(1,contentMode: .fit)
                            .edgesIgnoringSafeArea(.top)
                    
                    DescriptionView(task:task,tid:tid)
                }
                .edgesIgnoringSafeArea(.top)
                
                HStack {
                    if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                        Text("\(dataManager.tasks[index].Completeness)%")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button(action: {
                        dataManager.resetTask(tid:tid)
                        dataManager.resetTime(tid:tid)
                        refreshID = UUID()
                    }) {
                        Text("重新開始")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                            .padding()
                            .padding(.horizontal, 8)
                            .background(Color.white)
                            .cornerRadius(10.0)
                    }
                    NavigationLink(destination: PreVideoView(nowT: task)) {
                        Text("開始運動")
                            .font(.system(size: 16))
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
            .onAppear{
                refreshID = UUID()
            }
        }
    }


    struct RoundedCorner: Shape {

        var radius: CGFloat = .infinity
        var corners: UIRectCorner = .allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    extension View {
        func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape( RoundedCorner(radius: radius, corners: corners) )
        }
    }

    


    struct ColorDotView: View {
        let color: Color
        var body: some View {
            color
                .frame(width: 24, height: 24)
                .clipShape(Circle())
        }
    }

    struct DescriptionView: View {
        @EnvironmentObject var dataManager: DataManager
        let task:Task
        let tid:String
        @State private var refreshID = UUID()
        var body: some View {
            VStack (alignment: .leading) {
                //                Title
                if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                    Text("\(dataManager.tasks[index].id)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    
                }
               
                
                Text("內容")
                    .fontWeight(.medium)
                    .padding(.vertical, 8)
                Text("歡迎！讓我們一起創造美好的未來吧！")
                    .lineSpacing(8.0)
                    .opacity(0.6)
                    
                
                //                Info
                HStack (alignment: .top) {
                    VStack (alignment: .leading) {
                        if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                            Text("進度")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Text("完成度: \(dataManager.tasks[index].Completeness) %").opacity(0.6)
                            Text("目前輪次: \(dataManager.tasks[index].Current_iter)").opacity(0.6)
                            Text("使用時間: \(dataManager.tasks[index].stayTime) 秒").opacity(0.6)
                            
                        }
                    } .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        
                        if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                            Text("總覽")
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                            Text("總輪數: \(dataManager.tasks[index].Total_iter)").opacity(0.6)
                            Text("任務時長: \(dataManager.tasks[index].totalTime) 秒").opacity(0.6)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical)
                VStack (alignment: .leading) {
                    
                    Text("任務細節")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        
                    
//                        if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                            ForEach(task.taslitems, id: \.id) { task in
                                Text("\(task.id) ( \(task.click) 次 ) ").opacity(0.6)
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


    struct BackButton: View {
        let action: () -> Void
        var body: some View {
            Button(action: action) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.black)
                    .padding(.all, 12)
                    .background(Color.white)
                    .cornerRadius(8.0)
            }
        }
    }
