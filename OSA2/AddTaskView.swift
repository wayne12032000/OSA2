//
//  AddTaskView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//
import SwiftUI
struct AddTaskView: View {
//    @StateObject var dataManager = DataManager()
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isAlertPresented = false
    @State private var alertmessage = ""
    @State private var createError = false
    @State private var taskName = ""
    
    @State private var NameDuplicate = false
    
    
    @State private var Iter = 1
    @State private var Retropalatal = 0
    @State private var Retroglossal1 = 0
    @State private var Retroglossal2 = 0
    @State private var Retroglossal3 = 0
    @State private var Retroglossal4 = 0
    
    @State private var Retroglossal5 = 0
    @State private var Deglutition1 = 0
    @State private var Deglutition2 = 0
    @State private var TMJ1 = 0
    @State private var TMJ2 = 0
    
    @State private var Facial1 = 0
    @State private var Facial2 = 0
    @State private var Facial3 = 0
    @State private var Biceps = 0
    @State private var Calf = 0
    
    @State private var Chest = 0
    @State private var Flexors = 0
    @State private var Trunk  = 0
    @State private var M1 = 0
    @State private var M2 = 0
    
    @State private var Situp = 0
    
    @State private var imageNames = ["顎後運動","舌後運動 1~5","吞嚥運動 1~2","顳顎關節運動 1~2","臉部運動 1~3","伸展","伏地挺身","仰臥起坐"]
    @State private var selectedImageIndex = 0
    init() {
           // Set the page indicator colors
           UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.blue
           UIPageControl.appearance().pageIndicatorTintColor = UIColor.gray
       }
    
//    @State private var ta:[Int] = [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0 ,0,0,0,0,0, 0]
    
    var body: some View {
            
            VStack {
                TextField("為你的任務取個名字吧！", text: $taskName)
                    .foregroundColor(.black)
                   
                    .font(.system(.title3, design: .default).weight(.bold))

                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                    )
                    .padding(.horizontal)
                    .onAppear{
                        dataManager.isbarshow = false
                    }
//                HStack {
//                    
//                    
//                    TabView(selection: $selectedImageIndex) {
//                        ForEach(0..<imageNames.count, id: \.self) { index in
//                            Image(imageNames[index])
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                                .tag(index)
//                        }
//                    }
//                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//                    .frame(width: 150, height: 150)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//                    .padding(.vertical, 5)
//
//                }
//                .background(Color.gray)
//                .frame(maxWidth: .infinity)
//                .cornerRadius(10)
//                .padding(.horizontal)
//                .padding(.vertical, 5)

            ScrollView {
                VStack(spacing: 5)  {
                    TabView(selection: $selectedImageIndex) {
                        ForEach(0..<imageNames.count, id: \.self) { index in
                            Image(imageNames[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                .tag(index)
                                .padding(.bottom, 40)
                                .cornerRadius(10)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(width: 150, height: 150)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
//                    HStack{
//                        Text("總次數").frame(maxWidth: .infinity, alignment: .center).font(.title2)
//                        Picker(selection: $Iter, label: Text("")) {
//                            ForEach(1..<10,id:\.self){i in
//                                Text("\(i)").tag(i)
//                            }
//                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
//                    }
                    HStack {
                        Text("總輪數")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Iter, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(1..<2, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.purple) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 5)
                    HStack {
                        Text("01鬚鯨濾食")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Retropalatal, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("02金銅秤")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Retroglossal1, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("03戽斗星球")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Retroglossal2, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("04千斤頂")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Retroglossal3, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("05青蛙捕食")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Retroglossal4, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("06摩天輪")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Retroglossal5, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("07章魚吸盤")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Deglutition1, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("08小丑魚")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Deglutition2, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("09河豚鼓鼓")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $TMJ1, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("10一笑呷百二")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $TMJ2, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("11蛇吞象")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Facial1, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("12老虎示威")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Facial2, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("13我是演唱家")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Facial3, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.green) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("5-1 舌頭往前")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Biceps, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.indigo) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("5-2 舌頭往上")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Calf, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.indigo) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    
                    HStack {
                        Text("5-3 舌頭往下")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Chest, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.indigo) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("5-4 舌頭往左")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Flexors, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.indigo) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
                    HStack {
                        Text("5-5 舌頭往右")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.leading)
                            .foregroundColor(.white)
                        Picker(selection: $Trunk, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
                            ForEach(0..<10, id: \.self) { i in
                                Text("\(i)").tag(i)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 100, height: 50, alignment: .trailing)
                        .accentColor(.white)
                        .padding(.trailing)
                    }
                    .background(Color.indigo) // You can change `Color.gray` to any color you want.
                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
                    .cornerRadius(10) // Optional: If you want rounded corners.
                    .padding(.horizontal) // You can specify only horizontal padding if you want
                    .padding(.vertical, 1)
//                    HStack {
//                        Text("簡化版伏地挺身1")
//                            .font(.title3)
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            .padding(.leading)
//                            .foregroundColor(.white)
//                        Picker(selection: $M1, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
//                            ForEach(0..<10, id: \.self) { i in
//                                Text("\(i)").tag(i)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .frame(width: 100, height: 50, alignment: .trailing)
//                        .accentColor(.white)
//                        .padding(.trailing)
//                    }
//                    .background(Color.mint) // You can change `Color.gray` to any color you want.
//                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
//                    .cornerRadius(10) // Optional: If you want rounded corners.
//                    .padding(.horizontal) // You can specify only horizontal padding if you want
//                    .padding(.vertical, 1)
//                    HStack {
//                        Text("簡化版伏地挺身2")
//                            .font(.title3)
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            .padding(.leading)
//                            .foregroundColor(.white)
//                        Picker(selection: $M2, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
//                            ForEach(0..<10, id: \.self) { i in
//                                Text("\(i)").tag(i)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .frame(width: 100, height: 50, alignment: .trailing)
//                        .accentColor(.white)
//                        .padding(.trailing)
//                    }
//                    .background(Color.mint) // You can change `Color.gray` to any color you want.
//                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
//                    .cornerRadius(10) // Optional: If you want rounded corners.
//                    .padding(.horizontal) // You can specify only horizontal padding if you want
//                    .padding(.vertical, 1)
//                    HStack {
//                        Text("仰臥起坐")
//                            .font(.title3)
//                            .frame(maxWidth: .infinity, alignment: .center)
//                            .padding(.leading)
//                            .foregroundColor(.white)
//                        Picker(selection: $Situp, label: Text(" ").frame(maxWidth: .infinity, alignment: .trailing)) {
//                            ForEach(0..<10, id: \.self) { i in
//                                Text("\(i)").tag(i)
//                            }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .frame(width: 100, height: 50, alignment: .trailing)
//                        .accentColor(.white)
//                        .padding(.trailing)
//                    }
//                    .background(Color.teal) // You can change `Color.gray` to any color you want.
//                    .frame(maxWidth: .infinity) // This ensures the background color extends to the edges of the screen.
//                    .cornerRadius(10) // Optional: If you want rounded corners.
//                    .padding(.horizontal) // You can specify only horizontal padding if you want
//                    .padding(.vertical, 1)
                   
                }
            }
            Button("建立") {
                // 在这里处理收集到的变量
                var mission:[Mission] = []
                if Retropalatal>0{for i in 1...Retropalatal{mission.append( Mission(id: "01鬚鯨濾食", url: "o1OmeXPtauw", click: 5 ,time: 56,type: 0,pressure_data: []))}}
                if Retroglossal1>0{for i in 1...Retroglossal1{mission.append( Mission(id: "02金銅秤", url: "EFXozIuhcm0", click: 5 ,time: 55,type: 0,pressure_data: []))}}
                if Retroglossal2>0{for i in 1...Retroglossal2{mission.append(Mission(id: "03戽斗星球", url: "9TSyxqJKw_I", click: 5 ,time: 15,type: 0,pressure_data: []))}}
                if Retroglossal3>0{for i in 1...Retroglossal3{mission.append(Mission(id: "04千斤頂", url: "cz-K0jImBQw", click: 5 ,time: 15,type: 0,pressure_data: []))}}
                if Retroglossal4>0{for i in 1...Retroglossal4{mission.append( Mission(id: "05青蛙捕食", url: "KsHEFXzi5kA", click: 5 ,time: 44,type: 0,pressure_data: []))}}
                if Retroglossal5>0{for i in 1...Retroglossal5{mission.append( Mission(id: "06摩天輪", url: "wZYHIjo9Uik", click: 5 ,time: 55,type: 0,pressure_data: []))}}
                
                if Deglutition1>0{for i in 1...Deglutition1{mission.append(Mission(id: "07章魚吸盤", url: "Bz0eAeZtzso", click: 5,time: 15 ,type: 0,pressure_data: []))}}
                if Deglutition2>0{for i in 1...Deglutition2{mission.append(Mission(id: "08小丑魚", url: "xXvHt9Dyy2E", click: 5,time: 15,type: 0,pressure_data: [] ))}}
                if TMJ1>0{for i in 1...TMJ1{mission.append(Mission(id: "09河豚鼓鼓", url: "6avSx6WO6zk", click: 5,time: 31,type: 0,pressure_data: []))}}
                if TMJ2>0{for i in 1...TMJ2{mission.append(Mission(id: "10一笑呷百二", url: "QBWFkbtAZWs", click: 5 ,time: 15,type: 0,pressure_data: []))}}
                if Facial1>0{for i in 1...Facial1{mission.append(Mission(id: "11蛇吞象", url: "gJ34OWcihi0", click: 5 ,time: 45,type: 0,pressure_data: []))}}
                if Facial2>0{for i in 1...Facial2{mission.append(Mission(id: "12老虎示威", url: "c3pY61OQfXI", click: 5 ,time: 16,type: 0,pressure_data: []))}}
                if Facial3>0{for i in 1...Facial3{mission.append(Mission(id: "13我是演唱家", url: "kXKGtwbGej8", click: 5 ,time: 16,type: 0,pressure_data: []))}}
                
                if Biceps>0{for i in 1...Biceps{mission.append(Mission(id: "5-1 舌頭往前", url: "bReXegy0w-M", click: 5  ,time: 15,type: 1,pressure_data: []))}}
                if Calf>0{for i in 1...Calf{mission.append(Mission(id: "5-2 舌頭往上", url: "pMFw2mui9nA", click: 5 ,time: 15,type: 1,pressure_data: []))}}
                if Chest>0{for i in 1...Chest{mission.append(Mission(id: "5-3 舌頭往下", url: "4h5aFm4yYJk", click: 5 ,time: 15,type: 1,pressure_data: []))}}
                if Flexors>0{for i in 1...Flexors{mission.append(Mission(id: "5-4 舌頭往左", url: "cEs3QQDjINk", click: 5,time: 15,type: 1,pressure_data: [] ))}}
                if Trunk>0{for i in 1...Trunk{mission.append( Mission(id: "5-5 舌頭往右", url: "Hp6zBIQ-80o", click: 5,time: 15 ,type: 1,pressure_data: []))}}
//                if M1>0{for i in 1...M1{mission.append(Mission(id: "簡化版伏地挺身1", url: "9lKel2pFHxc", click: 16  ,time: 22))}}
//                if M2>0{for i in 1...M2{mission.append(Mission(id: "簡化版伏地挺身2", url: "1MHJ4gMGB34", click: 16 ,time: 22))}}
//                if Situp>0{for i in 1...Situp{mission.append(Mission(id: "仰臥起坐", url: "Yo8DsH6Phfw", click: 16  ,time: 25))}}
               
                   
                
                let newtask  = Task(id: taskName, taslitems: mission, Total_iter: Iter, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0, current_mission_index: 0, leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 0,imageuse:imageNames[selectedImageIndex])
               
                for mission in newtask.taslitems{
                    newtask.totalTime+=(mission.time*mission.click)
                }
                print("precreateerror = ",createError)
                if taskName==""{
                    alertmessage = "任務名稱不可空白！"
                    if newtask.totalTime==0{
                        alertmessage = "任務名稱不可空白！\n 您需要選取至少一個任務！"
                    }
                    createError.toggle()
                    isAlertPresented.toggle()
                    dataManager.isbarshow = false
                    print("aftercreateerror = ",createError)
                }else{
                    if newtask.totalTime==0{
                        alertmessage = "您需要選取至少一個任務！"
                        createError .toggle()
                        isAlertPresented.toggle()
                        dataManager.isbarshow = false
                        print("aftercreateerror1 = ",createError)
                    }else{
                        for task in dataManager.tasks{
                            if task.id == taskName{
                                NameDuplicate = true
                                alertmessage = "任務名稱已使用過，請換一個！"
                                break
                            }
                        }
                        if NameDuplicate{
                            createError .toggle()
                            isAlertPresented.toggle()
                            dataManager.isbarshow = false
                        }else{
                            print(newtask.totalTime)
                            dataManager.tasks.append(newtask)
                            print("in add:",dataManager.tasks.count)
                            isAlertPresented.toggle()
                            dataManager.isbarshow = false
                            print("aftercreateerror2 = ",createError)
                        }
                        
                    }
                }

            }
            .foregroundColor(.white)
            .font(.system(.title3, design: .default).weight(.bold))

            
            .frame(maxWidth: .infinity,maxHeight: 60)
            
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("Primary"))
            )
            .padding(.horizontal)
                
                
//                Text("Reset")
//                    .font(.title3)
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color("Primary"))
//                    .padding()
//                    .padding(.horizontal, 8)
//                    .background(Color.white)
//                    .cornerRadius(10.0)
                
                
                
                
                Spacer()
        }.alert(isPresented: $isAlertPresented) {
            if createError {
                Alert(
                    title: Text("很抱歉～"),
                    message: Text(alertmessage),
                    dismissButton: .default(Text("確定")){
                        // Dismiss the current view when the "確定" button is pressed
//                        presentationMode.wrappedValue.dismiss()
                        createError = false
                        NameDuplicate = false
                    }
                )
            }else{
                Alert(
                    title: Text("太棒了！"),
                    message: Text("建立成功，回上一頁看看吧！"),
                    dismissButton: .default(Text("確定")){
                        // Dismiss the current view when the "確定" button is pressed
                        createError = false
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
            
        }.onAppear{
            dataManager.isbarshow = false
        }
    }
}
    


#Preview {
    AddTaskView()

}

//                if Retropalatal {mission.append(Mission(id: "顎後運動", url: "8KVaGH7YzQU", click: <#Int#>))}
//                if Retroglossal1 {mission.append(Mission(id: "舌後運動1", url: "ps76iCcsMHE"))}
//                if Retroglossal2 {mission.append(Mission(id: "舌後運動2", url: "mvC0AFH489w"))}
//                if Retroglossal3 {mission.append(Mission(id: "舌後運動3", url: "jwyrO_3jNXc"))}
//                if Retroglossal4 {mission.append(Mission(id: "舌後運動4", url: "LEGZoj0a7Oo"))}
//
//                if Retroglossal5 {mission.append(Mission(id: "舌後運動5", url: "lzWXt2JH138"))}
//                if Deglutition1 {mission.append(Mission(id: "吞嚥運動1", url: "MlkJs6pj88g"))}
//                if Deglutition2 {mission.append(Mission(id: "吞嚥運動2", url: "8KVaGH7YzQU"))}
//                if TMJ1 {mission.append(Mission(id: "顳顎關節運動1", url: "Xzhs485xTZY"))}
//                if TMJ2 {mission.append(Mission(id: "顳顎關節運動2", url: "P-IxR_rZCPw"))}
//
//                if Facial1 {mission.append(Mission(id: "臉部運動1", url: "8KVaGH7YzQU"))}
//                if Facial2 {mission.append(Mission(id: "臉部運動2", url: "HGum7x4f9MA"))}
//                if Facial3 {mission.append(Mission(id: "臉部運動3", url: "8KVaGH7YzQU"))}
//                if Biceps {mission.append(Mission(id: "二頭肌伸展", url: "8KVaGH7YzQU"))}
//                if Calf {mission.append(Mission(id: "小腿伸展", url: "8KVaGH7YzQU"))}
//
//                if Chest {mission.append(Mission(id: "胸肌伸展", url: "8KVaGH7YzQU"))}
//                if Flexors {mission.append(Mission(id: "軀幹及髖關節屈肌伸展", url: "8KVaGH7YzQU"))}
//                if Trunk {mission.append(Mission(id: "頸部及背部伸展", url: "8KVaGH7YzQU"))}
//                if M1 {mission.append(Mission(id: "簡化版伏地挺身1", url: "8KVaGH7YzQU"))}
//                if M2 {mission.append(Mission(id: "簡化版伏地挺身2", url: "8KVaGH7YzQU"))}
//
//                if Situp {mission.append(Mission(id: "仰臥起坐", url: "8KVaGH7YzQU"))}
