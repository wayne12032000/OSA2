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
    @State private var showAlert = false
    var completeness: Int {
            Int(dataManager.tasks.first(where: { $0.id == tid })?.Completeness ?? 0)
        }

        var buttonTitle: String {
            if completeness >= 100 {
                return "已完成"
            } else if completeness > 0 {
                return "繼續課程"
            } else {
                return "開始課程"
            }
        }

        var isButtonDisabled: Bool {
            completeness >= 100
        }

        var buttonTextColor: Color {
            isButtonDisabled ? .gray : Color("Primary")
        }

        
    var body: some View {
        
            ZStack {
                Color("Bg")
                ScrollView  {
                    //            Product Image
                    if let image = UIImage(named: task.imageuse ) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(1,contentMode: .fit)
                                .edgesIgnoringSafeArea(.top)
                           
                        } else {
                            Image("伸展")
                                .resizable()
                                .aspectRatio(1,contentMode: .fit)
                                .edgesIgnoringSafeArea(.top)
                           
                        }
//                        Image("Dino6")
//                            .resizable()
//                            .aspectRatio(1,contentMode: .fit)
//                            .edgesIgnoringSafeArea(.top)
                    
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
                        showAlert = true
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

                    // Only show the button if completeness is less than 100
                        if completeness < 100 {
                            NavigationLink(destination: PreVideoView(nowT: task)) {
                                Text(buttonTitle)
                                    .font(.system(size: 16))
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Primary"))
                                    .padding()
                                    .padding(.horizontal, 8)
                                    .background(Color.white)
                                    .cornerRadius(10.0)
                            }
                            .disabled(isButtonDisabled)
                        } else {
                            // If needed, show a different label/text when completed.
                            // For example:
//                            Text("已完成")
//                                .font(.system(size: 16))
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .padding()
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
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("確認重新開始"),
                        message: Text("您確定要重新開始嗎？這將儲存這次課程的進度，並開啟新的進度。"),
                        primaryButton: .destructive(Text("重新開始")) {
                            dataManager.modifyHistoryTaskName(tid: tid)
                            dataManager.resetTask(tid: tid)
                            dataManager.resetTime(tid: tid)
                            dataManager.resetPressure_data(tid: tid)
                            
//                            dataManager.modifyHistoryTaskName(tid: tid)
                            refreshID = UUID()
                        },
                        secondaryButton: .cancel(Text("取消"))
                    )
                }
            }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: {
                presentationMode.wrappedValue.dismiss()
                dataManager.isbarshow = true
            }))
            .onAppear{
                //update pressure data
//                dataManager.updatePressureData(tid: tid)
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
               
//                
//                Text("內容")
//                    .fontWeight(.medium)
//                    .padding(.vertical, 8)
//                Text("歡迎！讓我們一起創造美好的未來吧！")
//                    .lineSpacing(8.0)
//                    .opacity(0.6)
                    
                
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
//                                Text("\(task.id) ( \(task.click) 次 ) ").opacity(0.6)
                                Text("\(task.id) \(task.type)").opacity(0.6)
//                                ForEach(task.pressure_data,id: \.id){ pdata in
//                                    Text("\(pdata.P)").opacity(0.3)
//                                    Text("\(pdata.T)").opacity(0.3)
//                                    Text("\(pdata.iter)").opacity(0.3)
//                                }
                                
                                
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
                    .background(Color("Bg"))
                    .cornerRadius(8.0)
            }
        }
    }
