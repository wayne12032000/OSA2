//
//  Userdata.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/20.
//


import Foundation
import SwiftUI

import WebKit


class Pressure_one_time:Codable,Identifiable{
    var P : [Int]
    var T : [String]
    var iter : Int
    init(P: [Int], T: [String], iter: Int) {
        self.P = P
        self.T = T
        self.iter = iter
    }
}



class Day:Codable,Identifiable{
    var id :String //date
    var tasks:[Task]
    init(id: String, tasks: [Task]) {
        self.id = id
        self.tasks = tasks
    }
    
    enum CodingKeys: String, CodingKey {
            case id
            case tasks
        }
}
class Task : Codable,Identifiable{
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
    var startTime:Date
    var stayTime:Int
    var totalTime:Int
    var imageuse:String
    
    init(id: String, taslitems: [Mission], Total_iter: Int, Total_click: Int, Current_iter: Int, Current_click: Int, Completeness: Int, current_mission_index: Int, leaveTime: Date, startTime: Date, stayTime: Int, totalTime: Int, imageuse: String) {
        self.id = id
        self.taslitems = taslitems
        self.Total_iter = Total_iter
        self.Total_click = Total_click
        self.Current_iter = Current_iter
        self.Current_click = Current_click
        self.Completeness = Completeness
        self.current_mission_index = current_mission_index
        self.leaveTime = leaveTime
        self.startTime = startTime
        self.stayTime = stayTime
        self.totalTime = totalTime
        self.imageuse = imageuse
    }
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            taslitems = try container.decodeIfPresent([Mission].self, forKey: .taslitems) ?? []
            Total_iter = try container.decodeIfPresent(Int.self, forKey: .Total_iter) ?? 0
            Total_click = try container.decodeIfPresent(Int.self, forKey: .Total_click) ?? 0
            Current_iter = try container.decodeIfPresent(Int.self, forKey: .Current_iter) ?? 0
            Current_click = try container.decodeIfPresent(Int.self, forKey: .Current_click) ?? 0
            Completeness = try container.decodeIfPresent(Int.self, forKey: .Completeness) ?? 0
            current_mission_index = try container.decodeIfPresent(Int.self, forKey: .current_mission_index) ?? 0
            leaveTime = try container.decode(Date.self, forKey: .leaveTime)
            startTime = try container.decode(Date.self, forKey: .startTime)
            stayTime = try container.decodeIfPresent(Int.self, forKey: .stayTime) ?? 0
            totalTime = try container.decodeIfPresent(Int.self, forKey: .totalTime) ?? 0
            imageuse = try container.decodeIfPresent(String.self, forKey: .imageuse) ?? "" // Provide a default empty string
        }
    enum CodingKeys: String, CodingKey {
            case id
            case taslitems
            case Total_iter
            case Total_click
            case Current_iter
            case Current_click
            case Completeness
            case current_mission_index
            case leaveTime = "leaveTime"
            case startTime = "startTime"
            case stayTime
            case totalTime
            case imageuse
        }
    
}
class Mission: Codable,Identifiable{
    var id:String
    var url:String
    var click:Int
    var time:Int
    var type:Int
    var pressure_data:[Pressure_one_time]
    
    init(id: String, url: String, click: Int, time: Int,type:Int,pressure_data:[Pressure_one_time]) {
        self.id = id
        self.url = url
        self.click = click
        self.time = time
        self.type = type
        self.pressure_data = pressure_data
    }
    enum CodingKeys: String, CodingKey {
            case id
            case url
            case click
            case time
            case type
            case pressure_data
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
class iconinfo:Codable,Identifiable{
    var id :String
    var iconName:String
    var cost:Int
    var OwnOrNot:Bool
    init(id: String, iconName: String, cost: Int, OwnOrNot: Bool) {
        self.id = id
        self.iconName = iconName
        self.cost = cost
        self.OwnOrNot = OwnOrNot
    }
}
extension Pressure_one_time {
    func deepCopy() -> Pressure_one_time {
        return Pressure_one_time(P: self.P, T: self.T, iter: self.iter)
    }
}

extension Mission {
    func deepCopy() -> Mission {
        return Mission(id: self.id, url: self.url, click: self.click, time: self.time, type: self.type, pressure_data: self.pressure_data.map { $0.deepCopy() })
    }
}

extension Task {
    func deepCopy() -> Task {
        return Task(
            id: self.id,
            taslitems: self.taslitems.map { $0.deepCopy() },
            Total_iter: self.Total_iter,
            Total_click: self.Total_click,
            Current_iter: self.Current_iter,
            Current_click: self.Current_click,
            Completeness: self.Completeness,
            current_mission_index: self.current_mission_index,
            leaveTime: self.leaveTime,
            startTime: self.startTime,
            stayTime: self.stayTime,
            totalTime: self.totalTime,
            imageuse: self.imageuse
        )
    }
}

extension Day {
    func deepCopy() -> Day {
        return Day(id: self.id, tasks: self.tasks.map { $0.deepCopy() })
    }
}


class DataManager: ObservableObject{
    
    @Published var username = ""
    
    
    @Published var token:String = ""
    
    @Published var isLogin:Bool = false
    
    @Published var iconInStore:[iconinfo] = [iconinfo(id: "Icon_black",iconName: "AppIcon 4", cost: 0, OwnOrNot: true),
                                             iconinfo(id: "Icon_blue",iconName: "AppIcon 1", cost: 200, OwnOrNot: false),
                                             iconinfo(id: "Icon_purple", iconName: "AppIcon 2",cost: 1000, OwnOrNot: false),
                                             iconinfo(id: "Icon_gold",iconName: "AppIcon 3", cost: 5000, OwnOrNot: false)]
    
    
    
    @Published var inactivityHours: Int = 12
    @Published var dailyReminderHour: Int = 8
    @Published var dailyReminderMinute: Int = 0
    @Published var PressureThreshold: Int = 30
    
    @Published var isbarshow:Bool = true
    @Published var DayHistory_backup:[Day] = [
        Day(id: "2024-12-11", tasks: [
            Task(
                id: "TestTask1211",
                taslitems: [
                    Mission(id: "Mission0", url: "url0", click: 6, time: 40, type: 0, pressure_data: [
                        Pressure_one_time(P: [12, 35, 8, 78, 3, 10, 11, 9, 16, 7], T: ["13:04:41", "13:04:12", "13:04:25", "13:04:47", "13:04:09", "13:04:32", "13:04:04", "13:04:20", "13:04:34", "13:04:03"], iter: 3),
                        Pressure_one_time(P: [14, 6, 20, 2, 18, 12, 13, 4, 5, 15], T: ["13:04:30", "13:04:50", "13:04:43", "13:04:18", "13:04:27", "13:04:15", "13:04:48", "13:04:39", "13:04:33", "13:04:51"], iter: 2),
                        Pressure_one_time(P: [16, 4, 6, 7, 17, 1, 9, 11, 8, 13], T: ["13:04:14", "13:04:23", "13:04:41", "13:04:19", "13:04:55", "13:04:17", "13:04:35", "13:04:22", "13:04:06", "13:04:40"], iter: 4)
                    ]),
                    Mission(id: "Mission1", url: "url1", click: 3, time: 25, type: 0, pressure_data: [
                        Pressure_one_time(P: [5, 11, 7, 10, 4, 15, 18, 20, 2, 14], T: ["13:04:26", "13:04:41", "13:04:38", "13:04:21", "13:04:08", "13:04:29", "13:04:48", "13:04:15", "13:04:39", "13:04:18"], iter: 1)
                    ])
                ],
                Total_iter: 5, Total_click: 10, Current_iter: 2, Current_click: 5, Completeness: 80, current_mission_index: 0, leaveTime: Date(), startTime: Date(), stayTime: 100, totalTime: 200, imageuse: ""
            ),
            Task(
                id: "TestTask1211s",
                taslitems: [
                    Mission(id: "Mission0", url: "url0", click: 4, time: 30, type: 0, pressure_data: [
                        Pressure_one_time(P: [9, 16, 4, 7, 10, 8, 11, 13, 15, 18], T: ["13:04:40", "13:04:25", "13:04:33", "13:04:47", "13:04:18", "13:04:21", "13:04:37", "13:04:19", "13:04:52", "13:04:34"], iter: 5),
                        Pressure_one_time(P: [14, 20, 3, 17, 19, 6, 2, 5, 8, 12], T: ["13:04:29", "13:04:42", "13:04:32", "13:04:10", "13:04:14", "13:04:09", "13:04:43", "13:04:51", "13:04:31", "13:04:20"], iter: 2)
                    ]),
                    Mission(id: "Mission1", url: "url1", click: 5, time: 35, type: 0, pressure_data: [
                        Pressure_one_time(P: [1, 5, 14, 7, 6, 20, 9, 11, 17, 4], T: ["13:04:23", "13:04:34", "13:04:11", "13:04:08", "13:04:47", "13:04:39", "13:04:56", "13:04:43", "13:04:19", "13:04:31"], iter: 3)
                    ])
                ],
                Total_iter: 6, Total_click: 8, Current_iter: 3, Current_click: 6, Completeness: 90, current_mission_index: 0, leaveTime: Date(), startTime: Date(), stayTime: 120, totalTime: 250, imageuse: ""
            )
        ] ),
        Day(id: "2024-12-10", tasks: [
            Task(
                id: "TestTask1210",
                taslitems: [
                    Mission(id: "Mission0", url: "url0", click: 6, time: 40, type: 0, pressure_data: [
                        Pressure_one_time(P: [12, 35, 8, 78, 3, 10, 11, 9, 16, 7], T: ["13:04:41", "13:04:12", "13:04:25", "13:04:47", "13:04:09", "13:04:32", "13:04:04", "13:04:20", "13:04:34", "13:04:03"], iter: 3),
                        Pressure_one_time(P: [14, 6, 20, 2, 18, 12, 13, 4, 5, 15], T: ["13:04:30", "13:04:50", "13:04:43", "13:04:18", "13:04:27", "13:04:15", "13:04:48", "13:04:39", "13:04:33", "13:04:51"], iter: 2),
                        Pressure_one_time(P: [16, 4, 6, 7, 17, 1, 9, 11, 8, 13], T: ["13:04:14", "13:04:23", "13:04:41", "13:04:19", "13:04:55", "13:04:17", "13:04:35", "13:04:22", "13:04:06", "13:04:40"], iter: 4)
                    ]),
                    Mission(id: "Mission1", url: "url1", click: 3, time: 25, type: 0, pressure_data: [
                        Pressure_one_time(P: [5, 11, 7, 10, 4, 15, 18, 20, 2, 14], T: ["13:04:26", "13:04:41", "13:04:38", "13:04:21", "13:04:08", "13:04:29", "13:04:48", "13:04:15", "13:04:39", "13:04:18"], iter: 1)
                    ])
                ],
                Total_iter: 5, Total_click: 10, Current_iter: 2, Current_click: 5, Completeness: 80, current_mission_index: 0, leaveTime: Date(), startTime: Date(), stayTime: 100, totalTime: 200, imageuse: ""
            ),
            Task(
                id: "TestTask1210s",
                taslitems: [
                    Mission(id: "Mission0", url: "url0", click: 4, time: 30, type: 0, pressure_data: [
                        Pressure_one_time(P: [9, 16, 4, 7, 10, 8, 11, 13, 15, 18], T: ["13:04:40", "13:04:25", "13:04:33", "13:04:47", "13:04:18", "13:04:21", "13:04:37", "13:04:19", "13:04:52", "13:04:34"], iter: 5),
                        Pressure_one_time(P: [14, 20, 3, 17, 19, 6, 2, 5, 8, 12], T: ["13:04:29", "13:04:42", "13:04:32", "13:04:10", "13:04:14", "13:04:09", "13:04:43", "13:04:51", "13:04:31", "13:04:20"], iter: 2)
                    ]),
                    Mission(id: "Mission1", url: "url1", click: 5, time: 35, type: 0, pressure_data: [
                        Pressure_one_time(P: [1, 5, 14, 7, 6, 20, 9, 11, 17, 4], T: ["13:04:23", "13:04:34", "13:04:11", "13:04:08", "13:04:47", "13:04:39", "13:04:56", "13:04:43", "13:04:19", "13:04:31"], iter: 3)
                    ])
                ],
                Total_iter: 6, Total_click: 8, Current_iter: 3, Current_click: 6, Completeness: 90, current_mission_index: 0, leaveTime: Date(), startTime: Date(), stayTime: 120, totalTime: 250, imageuse: ""
            )
        ] )
    ]
    
    
    @Published var DayHistory:[Day] = []
    
    
    @Published var customIcons: [String] = ["AppIcon", "AppIcon 1", "AppIcon 2", "AppIcon 3"]
    @Published var credit:Int = 100
//    "顎後運動","舌後運動 1~5","吞嚥運動 1~2","顳顎關節運動 1~2","臉部運動 1~3","伸展","伏地挺身","仰臥起坐"
    @Published var recommendTasks:[Task]=[
        Task(
            id: "顎後運動",
            taslitems: [
                Mission(id: "顎後運動", url: "seiXNzxKPik", click: 20 ,time: 21,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 21,imageuse: "顎後運動"
        ),Task(
            id: "舌後運動 1~5",
            taslitems: [
                Mission(id: "舌後運動1", url: "9zAt8ABAXs0", click: 20 ,time: 35,type: 0,pressure_data: []),
                Mission(id: "舌後運動2", url: "cp4AWJnow4s", click: 20 ,time: 27,type: 0,pressure_data: []),
                Mission(id: "舌後運動3", url: "DJK4LtPwXFg", click: 20 ,time: 18,type: 0,pressure_data: []),
                Mission(id: "舌後運動4", url: "1V7MH1X9Dto", click: 20 ,time: 19,type: 0,pressure_data: []),
                Mission(id: "舌後運動5", url: "8hC2u5pnBmY", click: 20 ,time: 35,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 134,imageuse: "舌後運動 1~5"
        ),
        Task(
            id: "吞嚥運動 1~2",
            taslitems: [
                Mission(id: "吞嚥運動1", url: "Yicz8l-IfEQ", click: 20,time: 23 ,type: 0,pressure_data: []),
                Mission(id: "吞嚥運動2", url: "4Khe-Zberoo", click: 20,time: 18 ,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 41,imageuse: "吞嚥運動 1~2"
        ),
        Task(
            id: "顳顎關節運動 1~2",
            taslitems: [
                Mission(id: "顳顎關節運動1", url: "HBv6mOtzY4Q", click: 20,time: 48,type: 0,pressure_data: []),
                Mission(id: "顳顎關節運動2", url: "s1eZJIX81Lo", click: 20 ,time: 31,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 79,imageuse: "顳顎關節運動 1~2"
        ),
        Task(
            id: "臉部運動 1~3",
            taslitems: [
                Mission(id: "臉部運動1", url: "P76sCKeH4Cs", click: 20 ,time: 29,type: 0,pressure_data: []),
                Mission(id: "臉部運動2", url: "sGsWSudxlxs", click: 20 ,time: 21,type: 0,pressure_data: []),
                Mission(id: "臉部運動3", url: "vNGahbISiMg", click: 20 ,time: 32,type: 0,pressure_data: [])
                 
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 81,imageuse: "臉部運動 1~3"
        ),
        Task(
            id: "伸展",
            taslitems: [
                Mission(id: "二頭肌伸展", url: "VolgzW3r3O4", click: 16  ,time: 41,type: 0,pressure_data: []),
                Mission(id: "小腿伸展", url: "MfPTdH8v4Ec", click: 16 ,time: 38,type: 0,pressure_data: []),
                Mission(id: "胸肌伸展", url: "0v_GYgaIe94", click: 16 ,time: 25,type: 0,pressure_data: []),
                Mission(id: "軀幹及髖關節屈肌伸展", url: "zf3PPPA7n6M", click: 16,time: 39 ,type: 0,pressure_data: []),
                Mission(id: "頸部及背部伸展", url: "wutvEPtcfUQ", click: 16,time: 36 ,type: 0,pressure_data: [])
                 
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 179,imageuse: "伸展"
        ),
        Task(
            id: "伏地挺身",
            taslitems: [
                Mission(id: "簡化版伏地挺身1", url: "9lKel2pFHxc", click: 16  ,time: 22,type: 0,pressure_data: []),
                Mission(id: "簡化版伏地挺身2", url: "1MHJ4gMGB34", click: 16 ,time: 22,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 44,imageuse: "伏地挺身"
        ),
        Task(
            id: "仰臥起坐",
            taslitems: [
                Mission(id: "仰臥起坐", url: "Yo8DsH6Phfw", click: 16  ,time: 25,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 25,imageuse: "仰臥起坐"
        )
    ]
//    if Retropalatal>0{for i in 1...Retropalatal{mission.append( Mission(id: "01鬚鯨濾食", url: "o1OmeXPtauw", click: 5 ,time: 56) )}}
//    if Retroglossal1>0{for i in 1...Retroglossal1{mission.append( Mission(id: "02金銅秤", url: "EFXozIuhcm0", click: 5 ,time: 55) )}}
//    if Retroglossal2>0{for i in 1...Retroglossal2{mission.append(Mission(id: "03戽斗星球", url: "9TSyxqJKw_I", click: 5 ,time: 15) )}}
//    if Retroglossal3>0{for i in 1...Retroglossal3{mission.append(Mission(id: "04千斤頂", url: "cz-K0jImBQw", click: 5 ,time: 15) )}}
//    if Retroglossal4>0{for i in 1...Retroglossal4{mission.append( Mission(id: "05青蛙捕食", url: "KsHEFXzi5kA", click: 5 ,time: 44) )}}
//    if Retroglossal5>0{for i in 1...Retroglossal5{mission.append( Mission(id: "06摩天輪", url: "wZYHIjo9Uik", click: 5 ,time: 55) )}}
//    
//    if Deglutition1>0{for i in 1...Deglutition1{mission.append(Mission(id: "07章魚吸盤", url: "Bz0eAeZtzso", click: 5,time: 15 ) )}}
//    if Deglutition2>0{for i in 1...Deglutition2{mission.append(Mission(id: "08小丑魚", url: "xXvHt9Dyy2E", click: 5,time: 15 ) )}}
//    if TMJ1>0{for i in 1...TMJ1{mission.append(Mission(id: "09河豚鼓鼓", url: "6avSx6WO6zk", click: 5,time: 31) )}}
//    if TMJ2>0{for i in 1...TMJ2{mission.append(Mission(id: "10一笑呷百二", url: "QBWFkbtAZWs", click: 5 ,time: 15) )}}
//    if Facial1>0{for i in 1...Facial1{mission.append(Mission(id: "11蛇吞象", url: "gJ34OWcihi0", click: 5 ,time: 45) )}}
//    if Facial2>0{for i in 1...Facial2{mission.append(Mission(id: "12老虎示威", url: "c3pY61OQfXI", click: 5 ,time: 16) )}}
//    if Facial3>0{for i in 1...Facial3{mission.append(Mission(id: "13我是演唱家", url: "kXKGtwbGej8", click: 5 ,time: 16) )}}
//    
//    if Biceps>0{for i in 1...Biceps{mission.append(Mission(id: "5-1 舌頭往前", url: "bReXegy0w-M", click: 5  ,time: 15) )}}
//    if Calf>0{for i in 1...Calf{mission.append(Mission(id: "5-2 舌頭往上", url: "pMFw2mui9nA", click: 5 ,time: 15) )}}
//    if Chest>0{for i in 1...Chest{mission.append(Mission(id: "5-3 舌頭往下", url: "4h5aFm4yYJk", click: 5 ,time: 15) )}}
//    if Flexors>0{for i in 1...Flexors{mission.append(Mission(id: "5-4 舌頭往左", url: "cEs3QQDjINk", click: 5,time: 15 ) )}}
//    if Trunk>0{for i in 1...Trunk{mission.append( Mission(id: "5-5 舌頭往右", url: "Hp6zBIQ-80o", click: 5,time: 15 ) )}}
    
    @Published var tasks_backup:[Task] = [
        Task(
            id: "13套動作",
            taslitems: [
                Mission(id: "01鬚鯨濾食", url: "o1OmeXPtauw", click: 5 ,time: 56,type: 0,pressure_data: []),
                Mission(id: "02金銅秤", url: "EFXozIuhcm0", click: 5 ,time: 55,type: 0,pressure_data: []),
                Mission(id: "03戽斗星球", url: "9TSyxqJKw_I", click: 5 ,time: 15,type: 0,pressure_data: []),
                Mission(id: "04千斤頂", url: "cz-K0jImBQw", click: 5 ,time: 15,type: 0,pressure_data: []),
                Mission(id: "05青蛙捕食", url: "KsHEFXzi5kA", click: 5 ,time: 44,type: 0,pressure_data: []),
                Mission(id: "06摩天輪", url: "wZYHIjo9Uik", click: 5 ,time: 55,type: 0,pressure_data: []),
                Mission(id: "07章魚吸盤", url: "Bz0eAeZtzso", click: 5,time: 15,type: 0,pressure_data: [] ),
                Mission(id: "08小丑魚", url: "xXvHt9Dyy2E", click: 5,time: 15 ,type: 0,pressure_data: []),
                Mission(id: "09河豚鼓鼓", url: "6avSx6WO6zk", click: 5,time: 31,type: 0,pressure_data: []),
                Mission(id: "10一笑呷百二", url: "QBWFkbtAZWs", click: 5 ,time: 15,type: 0,pressure_data: []),
                Mission(id: "11蛇吞象", url: "gJ34OWcihi0", click: 5 ,time: 45,type: 0,pressure_data: []),
                Mission(id: "12老虎示威", url: "c3pY61OQfXI", click: 5 ,time: 16,type: 0,pressure_data: []),
                Mission(id: "13我是演唱家", url: "kXKGtwbGej8", click: 5 ,time: 16,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 1965,imageuse: "setting_view"
           
        ),
        Task(
            id: "五大動作",
            taslitems: [
                Mission(id: "5-1 舌頭往前", url: "bReXegy0w-M", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-2 舌頭往上", url: "pMFw2mui9nA", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-3 舌頭往下", url: "4h5aFm4yYJk", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-4 舌頭往左", url: "cEs3QQDjINk", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-5 舌頭往右", url: "Hp6zBIQ-80o", click: 5 ,time: 15,type: 1,pressure_data: [])
                
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 375,imageuse: "setting_view"
           
        )
    ]
    
    
    @Published var tasks:[Task] = [
        Task(
            id: "13套動作",
            taslitems: [
                Mission(id: "01鬚鯨濾食", url: "o1OmeXPtauw", click: 5 ,time: 56,type: 0,pressure_data: []),
                Mission(id: "02金銅秤", url: "EFXozIuhcm0", click: 5 ,time: 55,type: 0,pressure_data: []),
                Mission(id: "03戽斗星球", url: "9TSyxqJKw_I", click: 5 ,time: 15,type: 0,pressure_data: []),
                Mission(id: "04千斤頂", url: "cz-K0jImBQw", click: 5 ,time: 15,type: 0,pressure_data: []),
                Mission(id: "05青蛙捕食", url: "KsHEFXzi5kA", click: 5 ,time: 44,type: 0,pressure_data: []),
                Mission(id: "06摩天輪", url: "wZYHIjo9Uik", click: 5 ,time: 55,type: 0,pressure_data: []),
                Mission(id: "07章魚吸盤", url: "Bz0eAeZtzso", click: 5,time: 15 ,type: 0,pressure_data: []),
                Mission(id: "08小丑魚", url: "xXvHt9Dyy2E", click: 5,time: 15,type: 0,pressure_data: [] ),
                Mission(id: "09河豚鼓鼓", url: "6avSx6WO6zk", click: 5,time: 31,type: 0,pressure_data: []),
                Mission(id: "10一笑呷百二", url: "QBWFkbtAZWs", click: 5 ,time: 15,type: 0,pressure_data: []),
                Mission(id: "11蛇吞象", url: "gJ34OWcihi0", click: 5 ,time: 45,type: 0,pressure_data: []),
                Mission(id: "12老虎示威", url: "c3pY61OQfXI", click: 5 ,time: 16,type: 0,pressure_data: []),
                Mission(id: "13我是演唱家", url: "kXKGtwbGej8", click: 5 ,time: 16,type: 0,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 1965,imageuse: "顎後運動"
           
        ),
        Task(
            id: "五大動作",
            taslitems: [
                Mission(id: "5-1 舌頭往前", url: "bReXegy0w-M", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-2 舌頭往上", url: "pMFw2mui9nA", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-3 舌頭往下", url: "4h5aFm4yYJk", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-4 舌頭往左", url: "cEs3QQDjINk", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-5 舌頭往右", url: "Hp6zBIQ-80o", click: 5 ,time: 15,type: 1,pressure_data: [])
                
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 375,imageuse: "舌後運動 1~5"
           
        ),
        Task(
            id: "test",
            taslitems: [
                Mission(id: "01鬚鯨濾食", url: "o1OmeXPtauw", click: 5 ,time: 56,type: 0,pressure_data: []),
                Mission(id: "5-1 舌頭往前", url: "bReXegy0w-M", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "02金銅秤", url: "EFXozIuhcm0", click: 5 ,time: 55,type: 0,pressure_data: []),
                Mission(id: "5-2 舌頭往上", url: "pMFw2mui9nA", click: 5 ,time: 15,type: 1,pressure_data: []),
                Mission(id: "5-3 舌頭往下", url: "4h5aFm4yYJk", click: 5 ,time: 15,type: 1,pressure_data: [])
            ],
            Total_iter: 1, Total_click: 0, Current_iter: 1, Current_click: 0, Completeness: 0,current_mission_index: 0,leaveTime: Date(),startTime: Date(),stayTime: 0,totalTime: 375,imageuse: "舌後運動 1~5"
           
        )]
    
    
    init(){
        loadData()
        
    }
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
    func resetPressure_data(tid:String){
        if let index = tasks.firstIndex(where: { $0.id == tid }) {
                for mission in tasks[index].taslitems { // Use a regular for loop
                    mission.pressure_data.removeAll() // Clear the pressure_data array
                }
            }
    }
    func resetTime(tid:String){
        if let index = tasks.firstIndex(where: { $0.id == tid }) {
            tasks[index].stayTime = 0
           
        }
    }
    func updatePressureData(tid:String){
        if let index = tasks.firstIndex(where: { $0.id == tid }) {
            tasks[index].taslitems[tasks[index].current_mission_index].pressure_data.removeAll()
        }
    }
    
    func modifyHistoryTaskName(tid: String) {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.string(from: currentDate)

        if let todayIndex = DayHistory.firstIndex(where: { $0.id == todayDate }) {
            for taskIndex in DayHistory[todayIndex].tasks.indices {
                if DayHistory[todayIndex].tasks[taskIndex].id == tid {
                    // Use leaveTime for the timestamp suffix
                    let leaveTime = DayHistory[todayIndex].tasks[taskIndex].leaveTime
                    formatter.dateFormat = "yyyyMMdd_HHmmss" // Example: 20241211_144530
                    let timestamp = formatter.string(from: leaveTime)

                    // Update the task ID
                    DayHistory[todayIndex].tasks[taskIndex].id = "\(tid)_\(timestamp)"
                    print("Updated DayHistory task ID to \(DayHistory[todayIndex].tasks[taskIndex].id)")
                    return
                }
            }
            print("Task with ID \(tid) not found in DayHistory for today.")
        } else {
            print("No entry for today in DayHistory.")
        }
    }

    func secondsToMinutesAndSeconds(seconds: Int) ->String {
        if seconds<3600{
            let minutes = seconds / 60
            let remainingSeconds = seconds % 60
            return "\(minutes)分 \(remainingSeconds)秒"
        }else{
            let hours = seconds / 3600
            let minutes = (seconds - (3600*hours))/60
            let remainseconds = (seconds - (3600*hours) - (minutes*60))
            return "\(hours)小時 \(minutes)分 \(remainseconds)秒"
        }
        
    }
    
    func saveData() {
        let taskEncoder = JSONEncoder()
        if let encodedTasks = try? taskEncoder.encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: "tasksKey")
        }

        let historyEncoder = JSONEncoder()
        if let encodedHistory = try? historyEncoder.encode(DayHistory) {
            UserDefaults.standard.set(encodedHistory, forKey: "DayHistoryKey")
        }
        
        let creditEncoder = JSONEncoder()
        if let encodedcredit = try? creditEncoder.encode(credit) {
            UserDefaults.standard.set(encodedcredit, forKey: "creditKey")
        }
        
        let iconEncoder = JSONEncoder()
        if let encodedicon = try? iconEncoder.encode(iconInStore) {
            UserDefaults.standard.set(encodedicon, forKey: "iconKey")
        }
        
        let inactivityEncoder = JSONEncoder()
        if let encodedicon = try? inactivityEncoder.encode(inactivityHours) {
            UserDefaults.standard.set(encodedicon, forKey: "inactivityHoursKey")
        }
        
        let dailyHourEncoder = JSONEncoder()
        if let encodedicon = try? dailyHourEncoder.encode(dailyReminderHour) {
            UserDefaults.standard.set(encodedicon, forKey: "dailyReminderHourKey")
        }
        
        let dailyMinutesEncoder = JSONEncoder()
        if let encodedicon = try? dailyHourEncoder.encode(dailyReminderMinute) {
            UserDefaults.standard.set(encodedicon, forKey: "dailyReminderMinuteKey")
        }
        
        let PressureThresholdEncoder = JSONEncoder()
        if let encodedicon = try? PressureThresholdEncoder.encode(PressureThreshold) {
            UserDefaults.standard.set(encodedicon, forKey: "PressureThresholdKey")
        }

       
    }

    // Function to load data from UserDefaults
    func loadData() {
        if let taskData = UserDefaults.standard.data(forKey: "tasksKey"),
           let decodedTasks = try? JSONDecoder().decode([Task].self, from: taskData) {
            tasks = decodedTasks
        }

        if let historyData = UserDefaults.standard.data(forKey: "DayHistoryKey"),
           let decodedHistory = try? JSONDecoder().decode([Day].self, from: historyData) {
            DayHistory = decodedHistory
        }
        
        if let creditData = UserDefaults.standard.data(forKey: "creditKey"),
           let decodedcredit = try? JSONDecoder().decode(Int.self, from: creditData) {
            credit = decodedcredit
        }
        
        if let iconData = UserDefaults.standard.data(forKey: "iconKey"),
           let decodedicon = try? JSONDecoder().decode([iconinfo].self, from: iconData) {
            iconInStore = decodedicon
        }
        
        if let inactivityData = UserDefaults.standard.data(forKey: "inactivityHoursKey"),
           let decodedicon = try? JSONDecoder().decode(Int.self, from: inactivityData) {
            inactivityHours = decodedicon
        }
        
        if let dailyReminderHourData = UserDefaults.standard.data(forKey: "dailyReminderHourKey"),
           let decodedicon = try? JSONDecoder().decode(Int.self, from: dailyReminderHourData ) {
            dailyReminderHour = decodedicon
        }
        
        if let dailyReminderMinuteData = UserDefaults.standard.data(forKey: "dailyReminderMinuteKey"),
           let decodedicon = try? JSONDecoder().decode(Int.self, from: dailyReminderMinuteData) {
            dailyReminderMinute = decodedicon
        }
        
        if let PressureThresholdData = UserDefaults.standard.data(forKey: "PressureThresholdKey"),
           let decodedicon = try? JSONDecoder().decode(Int.self, from: PressureThresholdData) {
            PressureThreshold = decodedicon
        }
    }

    
    func saveDataToFile() {
            do {
                // 获取文档目录的路径
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

                // 创建文件的完整路径
                let tasksURL = documentDirectory.appendingPathComponent("tasks.json")
                print("task_PATH : ",tasksURL)
                // 将数据写入文件
                let tasksData = try JSONEncoder().encode(tasks)
                try tasksData.write(to: tasksURL)

                // 同样的步骤保存其他数据
                let historyURL = documentDirectory.appendingPathComponent("history.json")
                print("history_PATH : ",historyURL)
                let historyData = try JSONEncoder().encode(DayHistory)
                try historyData.write(to: historyURL)

                let creditURL = documentDirectory.appendingPathComponent("credit.json")
                print("credit_PATH : ",tasksURL)
                let creditData = try JSONEncoder().encode(credit)
                try creditData.write(to: creditURL)

                // ... 类似地保存其他数据

                print("数据保存成功")
            } catch {
                print("保存数据到文件时出错: \(error)")
            }
        }
    
    
    func getTasksFileURL() -> URL? {
            do {
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let fileURL = documentDirectory.appendingPathComponent("tasks.json")
                
                // Debugging: Check if the file exists
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    print("File exists at path: \(fileURL.path)")
                    return fileURL
                } else {
                    print("File does not exist at expected path: \(fileURL.path)")
                    return nil
                }
            } catch {
                print("Error: \(error)")
                return nil
            }
        }
    
    func exportDayHistory() -> String? {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Makes the JSON easier to read.
            do {
                let jsonData = try encoder.encode(DayHistory)
                return String(data: jsonData, encoding: .utf8)
            } catch {
                print("Error encoding DayHistory: \(error)")
                return nil
            }
        }
    
    
    
    
    
    func uploadData(withToken token: String) {
        guard let url = URL(string: "http://140.116.245.33:8080/upload") else { return }
        
        // Configure the DateFormatter for ISO 8601
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")


        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)

        
        do {
            let userData = UserData(dayHistory: self.DayHistory, credit: self.credit, tasks: self.tasks)
            let body = try encoder.encode(userData)
            print(String(data: body, encoding: .utf8) ?? "Could not stringify request body")

            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpBody = body
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        // Update UI or alert the user as necessary
                        print("Error uploading data: \(error)")
                    }
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    DispatchQueue.main.async {
                        // Update UI or alert the user as necessary
                        print("Server returned status code \(httpResponse.statusCode)")
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    // Update UI or notify user of success
                    print("Upload successful")
                }
            }.resume()
        } catch {
            DispatchQueue.main.async {
                // Handle encoding error, update UI accordingly
                print("Error preparing data for upload: \(error)")
            }
        }
    }



    
    
    func downloadData(withToken token: String) {
        guard let url = URL(string: "http://140.116.245.33:8080/download") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization") // Include the token
        
        // Configure the DateFormatter for ISO 8601
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Adjust as needed to match your server's date format
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    // Handle error, update UI accordingly
                    print("No data received, or there was an error: \(String(describing: error))")
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    // Handle server error, update UI accordingly
                    print("Server returned an error")
                }
                return
            }
            
            do {
                let userData = try decoder.decode(UserData.self, from: data)
                DispatchQueue.main.async {
                    // Assuming UserData is compatible with your Swift structure
                    // Update your model data here
                    self?.DayHistory = userData.dayHistory
                    self?.credit = userData.credit
                    self?.tasks = userData.tasks
                }
            } catch {
                DispatchQueue.main.async {
                    // Handle decoding error, update UI accordingly
                    print("Error decoding data: \(error)")
                }
            }
        }
        task.resume()
    }


    
    
}
struct UserData: Codable {
    var dayHistory: [Day]
    var credit: Int
    var tasks: [Task]
    
    enum CodingKeys: String, CodingKey {
        case dayHistory = "dayHistory"
        case credit = "credit"
        case tasks = "tasks"
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
        
        
        //adjust pressure data
        self.updatePressureData()
        
    }
    func updatePressureData(){
        currentTask.taslitems[currentMissionIndex].pressure_data.removeAll()
    }
    func updatacompleteness(){
        currentTask.Completeness = currentTask.Current_click * 100 / (currentTask.Total_click)
        print("com:\(currentTask.Completeness)")
        
    }
    func updateUsingTime() {
        let timeDifference = currentTask.leaveTime.timeIntervalSince(currentTask.startTime)
        currentTask.stayTime += Int(timeDifference)
    }

    // Function to handle button clicks
    func handleButtonClick() {
        // Update the current mission's click counta
        if currentTask.Completeness>=100{
            isSummaryViewVisible = true
            isMissionComplete = true
        }else{
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
                    if currentTask.Current_iter > currentTask.Total_iter || currentTask.Completeness>=100 {
                        // Set the isSummaryViewVisible flag to true)
                        isSummaryViewVisible = true
                        print("isSummaryViewVisible : ",isSummaryViewVisible)
                        
                    }
                }
            }
            
           
            // Reset isMissionComplete flag
            isMissionComplete = false
        }
        
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
