////
////  dataManager.swift
////  OSA
////
////  Created by 張世維 on 2023/10/16.
////
//import SwiftUI
//import Foundation
////import AVFoundation
////import AVKit
//
//
//class DataManager: ObservableObject{
//    @Published var tasks:[Task] = []
//    @Published var Historys:[History] = []
////    @Published var audioPlayer: AVAudioPlayer!
////    @Published var isMusicPlay = false
//    //data store here
//    init(){
//        load_init()
//        loadData()
////        let sound = Bundle.main.path(forResource: "back", ofType: "mp3")
////        audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//    }
//    
//  
//    
//    
//    
//    func load_init(){
//        //load_init()
//        let a = Task(id: "test", taslitems: [Mission(id: "顎後運動", url: "https://firebasestorage.googleapis.com/v0/b/osar2-8dcd0.appspot.com/o/Retropalatal%20exercise%20%E9%A1%8E%E5%BE%8C%E9%81%8B%E5%8B%95.mp4?alt=media&token=f59f76b1-0d13-4716-bacb-0a0bba06b47a&_gl=1*4cx6v1*_ga*MTU0NTQ3NjA3NS4xNjkyNzYxNDM3*_ga_CW55HF8NVT*MTY5NzQ2MjM2My4yOS4xLjE2OTc0NjIzOTIuMzEuMC4w")])
//        self.tasks.append(a)
//    }
//    // Function to save data to UserDefaults
//        func saveData() {
//            let taskEncoder = JSONEncoder()
//            if let encodedTasks = try? taskEncoder.encode(tasks) {
//                UserDefaults.standard.set(encodedTasks, forKey: "tasksKey")
//            }
//
//            let historyEncoder = JSONEncoder()
//            if let encodedHistory = try? historyEncoder.encode(Historys) {
//                UserDefaults.standard.set(encodedHistory, forKey: "historysKey")
//            }
//        }
//
//        // Function to load data from UserDefaults
//        func loadData() {
//            if let taskData = UserDefaults.standard.data(forKey: "tasksKey"),
//               let decodedTasks = try? JSONDecoder().decode([Task].self, from: taskData) {
//                tasks = decodedTasks
//            }
//
//            if let historyData = UserDefaults.standard.data(forKey: "historysKey"),
//               let decodedHistory = try? JSONDecoder().decode([History].self, from: historyData) {
//                Historys = decodedHistory
//            }
//        }
//}
