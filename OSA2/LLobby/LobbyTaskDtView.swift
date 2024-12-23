import SwiftUI

struct LobbyTaskDtView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var dataManager: DataManager
    let task: Task
    let tid: String
    @State private var refreshID = UUID()
    @State private var isaddshow = false
    
    var body: some View {
        ZStack {
            Color("Bg")
            ScrollView  {
                Image("\(task.id)")
                    .resizable()
                    .aspectRatio(1,contentMode: .fit)
                    .edgesIgnoringSafeArea(.top)
                DesView(task: task, tid: tid)
            }
            .edgesIgnoringSafeArea(.top)
            
            HStack {
                Spacer()
                Button(action: {
                    dataManager.tasks.append(task)
                    refreshID = UUID()
                    isaddshow.toggle()
                }) {
                    Text("加入至我的最愛")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Primary"))
                        .padding()
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .cornerRadius(10.0)
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
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: {
                presentationMode.wrappedValue.dismiss()
                dataManager.isbarshow = true
            }))
            .onAppear{
                refreshID = UUID()
            }
            .alert(isPresented: $isaddshow) {
//                if isaddshow {
                    Alert(
                        title: Text("新增成功～"),
                        message: Text("請至我的最愛開始任務吧！"),
                        dismissButton: .default(Text("確定")){
                            isaddshow = false
                            presentationMode.wrappedValue.dismiss()
                            
                        }
                    )
                }
//            }
        
    }
    
    
}

struct DesView: View {
    @EnvironmentObject var dataManager: DataManager
    let task: Task
    let tid: String
    @State private var refreshID = UUID()
    
    var body: some View {
        VStack (alignment: .leading) {
            if let index = dataManager.recommendTasks.firstIndex(where: { $0.id == tid }) {
                Text("\(dataManager.recommendTasks[index].id)")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Text("內容")
                .fontWeight(.medium)
                .padding(.vertical, 8)
            Text("歡迎！讓我們一起創造美好的未來吧！")
                .lineSpacing(8.0)
                .opacity(0.6)
            HStack (alignment: .top) {
                VStack (alignment: .leading) {
                    if let index = dataManager.recommendTasks.firstIndex(where: { $0.id == tid }) {
                        Text("總覽")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        Text("輪數: \(dataManager.recommendTasks[index].Total_iter)").opacity(0.6)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)
            VStack (alignment: .leading) {
                Text("任務細節")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                ForEach(task.taslitems, id: \.id) { task in
                    Text("\(task.id) ( \(task.click) 次 ) ").opacity(0.6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
    }
}
