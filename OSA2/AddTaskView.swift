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
    @State private var taskName = ""
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
    
//    @State private var ta:[Int] = [0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0 ,0,0,0,0,0, 0]
    
    var body: some View {
            
            VStack {
                TextField("為你的任務取個名字吧！", text: $taskName)
                    .foregroundColor(.black)
                    .font(.title3)
                    .bold()
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
            ScrollView {
                VStack {
                    HStack{
                        Text("總次數").frame(maxWidth: .infinity, alignment: .center).font(.title2)
                        Picker(selection: $Iter, label: Text("")) {
                            ForEach(1..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("顎後運動").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Retropalatal, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("舌後運動1").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Retroglossal1, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("舌後運動2").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Retroglossal2, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("舌後運動3").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Retroglossal3, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("舌後運動4").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Retroglossal4, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("舌後運動5").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Retroglossal5, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("吞嚥運動1").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Deglutition1, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("吞嚥運動2").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Deglutition2, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("顳顎關節運動1").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $TMJ1, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("顳顎關節運動2").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $TMJ2, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("臉部運動1").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Facial1, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("臉部運動2").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Facial2, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("臉部運動3").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Facial3, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("二頭肌伸展").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Biceps, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("小腿伸展").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Calf, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("胸肌伸展").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Chest, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("軀幹及髖關節屈肌伸展").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Flexors, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("頸部及背部伸展").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Trunk, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("簡化版伏地挺身1").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $M1, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("簡化版伏地挺身2").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $M2, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                    HStack{
                        Text("仰臥起坐").frame(maxWidth: .infinity, alignment: .center)
                        Picker(selection: $Situp, label: Text("")) {
                            ForEach(0..<10,id:\.self){i in
                                Text("\(i)").tag(i)
                            }
                        }.pickerStyle(WheelPickerStyle()).frame(width: 100,height: 50)
                    }
                }
            }.frame(maxHeight: 500)
            Button("建立") {
                // 在这里处理收集到的变量
                var mission:[Mission] = []
                if Retropalatal>0{for i in 1...Retropalatal{mission.append(Mission(id: "顎後運動", url: "8KVaGH7YzQU", click: 20 ))}}
                if Retroglossal1>0{for i in 1...Retroglossal1{mission.append(Mission(id: "舌後運動1", url: "ps76iCcsMHE", click: 20 ))}}
                if Retroglossal2>0{for i in 1...Retroglossal2{mission.append(Mission(id: "舌後運動2", url: "mvC0AFH489w", click: 20 ))}}
                if Retroglossal3>0{for i in 1...Retroglossal3{mission.append(Mission(id: "舌後運動3", url: "jwyrO_3jNXc", click: 20 ))}}
                if Retroglossal4>0{for i in 1...Retroglossal4{mission.append(Mission(id: "舌後運動4", url: "LEGZoj0a7Oo", click: 20 ))}}
                if Retroglossal5>0{for i in 1...Retroglossal5{mission.append(Mission(id: "舌後運動5", url: "lzWXt2JH138", click: 20 ))}}
                
                if Deglutition1>0{for i in 1...Deglutition1{mission.append(Mission(id: "吞嚥運動1", url: "MlkJs6pj88g", click: 20 ))}}
                if Deglutition2>0{for i in 1...Deglutition2{mission.append(Mission(id: "吞嚥運動2", url: "8KVaGH7YzQU", click: 20 ))}}
                if TMJ1>0{for i in 1...TMJ1{mission.append(Mission(id: "顳顎關節運動1", url: "Xzhs485xTZY", click: 20 ))}}
                if TMJ2>0{for i in 1...TMJ2{mission.append(Mission(id: "顳顎關節運動2", url: "P-IxR_rZCPw", click: 20 ))}}
                if Facial1>0{for i in 1...Facial1{mission.append(Mission(id: "臉部運動1", url: "8KVaGH7YzQU", click: 20 ))}}
                if Facial2>0{for i in 1...Facial2{mission.append(Mission(id: "臉部運動2", url: "HGum7x4f9MA", click: 20 ))}}
                if Facial3>0{for i in 1...Facial3{mission.append(Mission(id: "臉部運動3", url: "8KVaGH7YzQU", click: 20 ))}}
                
                if Biceps>0{for i in 1...Biceps{mission.append(Mission(id: "二頭肌伸展", url: "8KVaGH7YzQU", click: 20 ))}}
                if Calf>0{for i in 1...Calf{mission.append(Mission(id: "小腿伸展", url: "8KVaGH7YzQU", click: 20 ))}}
                if Chest>0{for i in 1...Chest{mission.append(Mission(id: "胸肌伸展", url: "8KVaGH7YzQU", click: 20 ))}}
                if Flexors>0{for i in 1...Flexors{mission.append(Mission(id: "軀幹及髖關節屈肌伸展", url: "8KVaGH7YzQU", click: 20 ))}}
                if Trunk>0{for i in 1...Trunk{mission.append(Mission(id: "頸部及背部伸展", url: "8KVaGH7YzQU", click: 20 ))}}
                if M1>0{for i in 1...M1{mission.append(Mission(id: "簡化版伏地挺身1", url: "8KVaGH7YzQU", click: 20 ))}}
                if M2>0{for i in 1...M2{mission.append(Mission(id: "簡化版伏地挺身2", url: "8KVaGH7YzQU", click: 20 ))}}
                if Situp>0{for i in 1...Situp{mission.append(Mission(id: "仰臥起坐", url: "8KVaGH7YzQU", click: 20 ))}}
               
                   
                          
                let newtask  = Task(id: taskName, taslitems: mission, Total_iter: Iter, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0, current_mission_index: 0, leaveTime: Date())
                dataManager.tasks.append(newtask)
                print("in add:",dataManager.tasks.count)
//                dataManager.saveData()
                isAlertPresented.toggle()
                dataManager.isbarshow = false
            }
            .foregroundColor(.white)
            .font(.title3)
            .bold()
            
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
            Alert(
                title: Text("太棒了！"),
                message: Text("建立成功，回上一頁看看吧！\(Retropalatal),\(Retroglossal1),\(Retroglossal2)"),
                dismissButton: .default(Text("確定")){
                    // Dismiss the current view when the "確定" button is pressed
                    presentationMode.wrappedValue.dismiss()
                }
            )
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
