import SwiftUI

struct PreVideoView: View {
    @EnvironmentObject var dataManager: DataManager
    let nowT:Task
    var body: some View {
//        NavigationView {
            let currentTask = nowT
            let taskManager = TaskManager(task: currentTask)
            let taskid = currentTask.id
            
            VideoPlayerView(taskManager:taskManager, taskid:taskid)
            
        
        
            
//        }
    }
}
