import SwiftUI

struct SummaryView: View {
    @ObservedObject var taskManager: TaskManager
    @EnvironmentObject var dataManager: DataManager
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

            
        }
    }
}
