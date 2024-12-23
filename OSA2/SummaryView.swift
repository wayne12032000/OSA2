import SwiftUI

struct SummaryView: View {
    @ObservedObject var taskManager: TaskManager
    @EnvironmentObject var dataManager: DataManager
    let taskid:String
    @Environment(\.presentationMode) var presentationMode
//    @State private var isPersonViewPresented = false // 添加状态变量

    var body: some View {
        ZStack { // 使用 ZStack 布局
            // 内容视图
            VStack {
                Text("Task Summary")
                    .font(.largeTitle)
                    .padding()

                Text("Total Clicks: \(taskManager.currentTask.Total_click)")
                Text("Total Iterations: \(taskManager.currentTask.Total_iter)")

                // 使用按钮来显示/隐藏 PersonView
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    presentationMode.wrappedValue.dismiss()
//                    isPersonViewPresented = true
                }) {
                    Text("返回我的任務")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                        )
                        .padding(.horizontal)
                }
                .padding()
            }

            
        }.onAppear{
            dataManager.credit+=100
            //update history
            let fixdate = Date()
            var formattedDate: String {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: fixdate)
                return dateString
            }
            if let dayindex = dataManager.DayHistory.firstIndex(where: { $0.id == formattedDate }) {
                if let taskdex = dataManager.DayHistory[dayindex].tasks.firstIndex(where: { $0.id == taskid }) {
                    if dataManager.DayHistory[dayindex].tasks[taskdex].Completeness<=100{
                        if let index = dataManager.tasks.firstIndex(where: { $0.id == taskid }) {
                            
                            dataManager.DayHistory[dayindex].tasks[taskdex].Completeness = 100
                        }else{
                            print("更新進度失敗")
                        }
                    }
                }else{
                    //append new task to found day
                    let taskhistory = taskManager.currentTask
                    print(taskhistory.Completeness)
                    dataManager.DayHistory[dayindex].tasks.append(taskhistory)
                }
                    
            
            }else{
                let dayhistory = Day(id: formattedDate, tasks: [taskManager.currentTask])
                dataManager.DayHistory.append(dayhistory)
            }
        }
    }
}
