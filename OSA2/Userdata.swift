//
//  Userdata.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/20.
//


import Foundation
import SwiftUI

import WebKit

class Task : Codable{
    // Properties
    var id: String
    var taslitems: [Mission]
    var Total_iter:Int
    var Total_click:Int
    var Current_iter:Int
    var Current_click:Int
    var Completeness:Int
    var current_mission_index:Int
    var leaveTime:Date
    
    init(id: String, taslitems: [Mission], Total_iter: Int, Total_click: Int, Current_iter: Int, Current_click: Int, Completeness: Int, current_mission_index: Int, leaveTime: Date) {
        self.id = id
        self.taslitems = taslitems
        self.Total_iter = Total_iter
        self.Total_click = Total_click
        self.Current_iter = Current_iter
        self.Current_click = Current_click
        self.Completeness = Completeness
        self.current_mission_index = current_mission_index
        self.leaveTime = leaveTime
        
    }
    
}
class Mission: Codable{
    var id:String
    var url:String
    var click:Int
    init(id: String, url: String, click: Int) {
        self.id = id
        self.url = url
        self.click = click
    }
}

class LOG:Codable{
    var taskitem_index:Int
    var at_click:Int
    var leave_time:Date
    var Completeness:Int
    init(taskitem_index: Int, at_click: Int, leave_time: Date, Completeness: Int) {
        self.taskitem_index = taskitem_index
        self.at_click = at_click
        self.leave_time = leave_time
        self.Completeness = Completeness
    }
}


class DataManager: ObservableObject{
    @Published var isbarshow:Bool = true
    
    @Published var customIcons: [String] = ["AppIcon", "AppIcon 1", "AppIcon 2", "AppIcon 3"]
    @Published var credit:Int = 100
    
    @Published var recommendTasks:[Task]=[
        Task(
            id: "顎後運動",
            taslitems: [
                Mission(id: "顎後運動", url: "8KVaGH7YzQU", click: 20 )
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date()
        ),Task(
            id: "舌後運動 1~5",
            taslitems: [
                Mission(id: "舌後運動1", url: "ps76iCcsMHE", click: 20 ),
                Mission(id: "舌後運動2", url: "mvC0AFH489w", click: 20 ),
                Mission(id: "舌後運動3", url: "jwyrO_3jNXc", click: 20 ),
                Mission(id: "舌後運動4", url: "LEGZoj0a7Oo", click: 20 ),
                Mission(id: "舌後運動5", url: "lzWXt2JH138", click: 20 )
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date()
        ),
        Task(
            id: "吞嚥運動 1~2",
            taslitems: [
                Mission(id: "吞嚥運動1", url: "MlkJs6pj88g", click: 20 ),
                Mission(id: "吞嚥運動2", url: "8KVaGH7YzQU", click: 20 )
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date()
        ),
        Task(
            id: "顳顎關節運動 1~2",
            taslitems: [
                Mission(id: "顳顎關節運動1", url: "Xzhs485xTZY", click: 20),
                Mission(id: "顳顎關節運動2", url: "P-IxR_rZCPw", click: 20 )
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date()
        ),
        Task(
            id: "臉部運動 1~3",
            taslitems: [
                Mission(id: "臉部運動1", url: "8KVaGH7YzQU", click: 20 ),
                Mission(id: "臉部運動2", url: "8KVaGH7YzQU", click: 20 ),
                Mission(id: "臉部運動3", url: "8KVaGH7YzQU", click: 20 )
                 
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date()
        ),
        Task(
            id: "伸展",
            taslitems: [
                Mission(id: "二頭肌伸展", url: "8KVaGH7YzQU", click: 20 ),
                Mission(id: "小腿伸展", url: "8KVaGH7YzQU", click: 20 ),
                Mission(id: "胸肌伸展", url: "8KVaGH7YzQU", click: 20 ),
                Mission(id: "軀幹及髖關節屈肌伸展", url: "8KVaGH7YzQU", click: 20 ),
                Mission(id: "頸部及背部伸展", url: "8KVaGH7YzQU", click: 20 )
                 
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date()
        )
    ]
    
    
    @Published var tasks:[Task] = [
        Task(
            id: "Test1",
            taslitems: [
                Mission(id: "mission0", url: "8KVaGH7YzQU", click: 5),
                Mission(id: "mission1", url: "ps76iCcsMHE", click: 3),
                Mission(id: "mission2", url: "8KVaGH7YzQU", click: 4)
            ],
            Total_iter: 4, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date()
           
        ),
        Task(
            id: "Test2",
            taslitems: [
                Mission(id: "mission0", url: "8KVaGH7YzQU", click: 5),
                Mission(id: "mission1", url: "ps76iCcsMHE", click: 3),
                Mission(id: "mission2", url: "8KVaGH7YzQU", click: 4)
            ],
            Total_iter: 4, Total_click: 0, Current_iter: 3, Current_click: 0, Completeness: 0,current_mission_index: 2,leaveTime: Date()
           
        )
    ]
    
    func resetTask(tid:String){
        if let index = tasks.firstIndex(where: { $0.id == tid }) {
            tasks[index].Completeness = 0
            tasks[index].Current_iter = 1
            tasks[index].current_mission_index = 0
           
        }
    }
    func resetrecTask(tid:String){
        if let index = recommendTasks.firstIndex(where: { $0.id == tid }) {
            recommendTasks[index].Completeness = 0
            recommendTasks[index].Current_iter = 1
            recommendTasks[index].current_mission_index = 0
           
        }
    }
    
}

//i will pass a Task object to a view called VideoView,




class TaskManager: ObservableObject {
    @Published var currentTask: Task
    @Published var currentMissionIndex: Int
    @Published var isMissionComplete: Bool
    @Published var isSummaryViewVisible: Bool // Add this property
    @Published var current_iter:Int
    @Published var current_click:Int
    @Published var isVideoPlaying: Bool
    
    init(task: Task) {
        self.currentTask = task
        self.currentMissionIndex = task.current_mission_index
        self.current_click = 0
        self.current_iter = task.Current_iter
        
        self.isVideoPlaying = false
        self.isMissionComplete = false
        self.isSummaryViewVisible = false // Initialize as false
        self.initcompleteness()
    }
    func initcompleteness(){
        currentTask.Current_click = 0
        if currentTask.Current_iter == 1{
            if currentTask.current_mission_index>0{
                for i in 0...currentTask.current_mission_index-1{
                    currentTask.Current_click+=currentTask.taslitems[i].click
                }
            }
        }else if currentTask.Current_iter>1{
            for i in currentTask.taslitems{
                currentTask.Current_click+=i.click
            }
            currentTask.Current_click*=(currentTask.Current_iter-1)
            if currentTask.current_mission_index>0{
                for i in 0...currentTask.current_mission_index-1{
                    currentTask.Current_click+=currentTask.taslitems[i].click
                }
            }
        }
        
        
            
        print("currrent click = \(currentTask.Current_click)")
        
        
        currentTask.Total_click=0
        for i in currentTask.taslitems{
            currentTask.Total_click+=i.click
        }
        currentTask.Total_click*=currentTask.Total_iter
        print("ctotal click = \(currentTask.Total_click)")
        self.updatacompleteness()
        
    }
    func updatacompleteness(){
        currentTask.Completeness = currentTask.Current_click * 100 / (currentTask.Total_click)
        print("com:\(currentTask.Completeness)")
        
    }
   
    // Function to handle button clicks
    func handleButtonClick() {
        // Update the current mission's click counta
        
        current_click += 1
        currentTask.Current_click+=1
        print("cik:\(currentTask.Current_click) Tik:\(currentTask.Total_click)")
        print("citer:\(currentTask.Current_iter) Titer:\(currentTask.Total_iter)")
        self.updatacompleteness()
        // Check if the mission is complete
        if current_click >= currentTask.taslitems[currentMissionIndex].click{
            currentMissionIndex += 1
            currentTask.current_mission_index = currentMissionIndex
            current_click = 0
            // Check if all missions in the task are complete
            if currentMissionIndex >= currentTask.taslitems.count {
                currentMissionIndex = 0
                currentTask.current_mission_index = currentMissionIndex
                currentTask.Current_iter += 1

                // Check if Total_iter has been achieved
                if currentTask.Current_iter > currentTask.Total_iter {
                    // Set the isSummaryViewVisible flag to true
                    isSummaryViewVisible = true
                    print(isSummaryViewVisible)
                    
                }
            }
        }
        
       
        // Reset isMissionComplete flag
        isMissionComplete = false
    }
   
}

//struct YouTubePlayerView: UIViewRepresentable {
//    var videoID: String
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
//            return
//        }
//        let request = URLRequest(url: youtubeURL)
//        uiView.load(request)
//    }
//}
