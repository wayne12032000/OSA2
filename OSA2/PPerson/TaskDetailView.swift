//
//  TaskDetailView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    let task:Task
    let tid:String
    @State private var refreshID = UUID()
    //    @State private var taskk:Task
    var body: some View {
        VStack{
           
            if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                // 现在，`index` 包含了任务的索引位置
                //                print("任务 '\(taskIDToFind)' 在数组中的索引位置是 \(index)")
                Text("\(dataManager.tasks[index].id)")
                Text("completeness \(dataManager.tasks[index].Completeness)")
                Text("c_iter \(dataManager.tasks[index].Current_iter)")
                Text("c_index \(dataManager.tasks[index].current_mission_index)")
            }
            
            
            
            List{
                ForEach(task.taslitems, id: \.id) { task in
                    Text(task.id)
                }
            }
            
            NavigationLink(destination: PreVideoView(nowT: task)) {
                Text("Start \(task.id)")
            }
            Button(action: {
                dataManager.resetTask(tid:tid)
                refreshID = UUID()
            }) {
                Text("Reset")
            }
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
        } .id(refreshID)
    }
}


