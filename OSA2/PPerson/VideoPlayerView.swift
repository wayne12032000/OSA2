////
////  VideoPlayerView.swift
////  OSA2
////
////  Created by 張世維 on 2023/10/20.
////
//
//import SwiftUI
//
//struct VideoPlayerView: View {
//    @ObservedObject var taskManager: TaskManager
//    @State private var clickCount = 0
//
//    var body: some View {
//        
//        if taskManager.isMissionComplete {
//                    // Transition to SummaryView when Total_iter is achieved
//                    SummaryView(taskManager: taskManager)
//        } else {
//            VStack {
//                Text("ID : \(taskManager.currentTask.taslitems[taskManager.currentMissionIndex].id)")
//                Text("Video URL: \(taskManager.currentTask.taslitems[taskManager.currentMissionIndex].url)")
//                
//                // Implement your YouTube video player here. You can use a WebView or other video player libraries.
//                Text("iter:\(taskManager.currentTask.Current_iter)/\(taskManager.currentTask.Total_iter)")
//                Text("Click Count: \(taskManager.current_click)/\(taskManager.currentTask.taslitems[taskManager.currentMissionIndex].click)")
//                //            Text()
//                Button("Click") {
//                    clickCount += 1
//                    taskManager.handleButtonClick()
//                }
//            }
//            .onReceive(taskManager.$isMissionComplete) { missionComplete in
//                if missionComplete {
//                    clickCount = 0 // Reset the click count
//                }
//            }
//        }
//    }
//}
//
//
import SwiftUI
import AVKit
import UIKit
import WebKit
struct VideoPlayerView: View {
    @EnvironmentObject var dataManager: DataManager
    @ObservedObject var taskManager:TaskManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let taskid:String
    @State private var clickCount = 0
    @State private var isVideoPlaying = false
    @State private var isPlaying = true
    var body: some View {
        
        if !taskManager.isSummaryViewVisible {
            
               
            VStack (alignment: .leading){
                YouTubePlayerView(videoID:taskManager.currentTask.taslitems[taskManager.currentMissionIndex].url,isPlaying: isPlaying)
                VStack(alignment: .leading){
                    HStack(alignment: .top) {
                        if let index = dataManager.tasks.firstIndex(where: { $0.id == taskid }) {
                            Text("\(dataManager.tasks[index].Completeness) %")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                
                        
                        }
                        Spacer()
                        Button("繼續") {
                            clickCount += 1
                            
                            
                            taskManager.handleButtonClick()
                            isVideoPlaying = true
                            isPlaying.toggle()
                            
                            
                        } .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Primary"))
                            .padding()
                            .padding(.horizontal, 8)
                            .background(Color.white)
                            .cornerRadius(10.0)
                            .frame(alignment: .top)
                    }.padding()
                        .padding(.horizontal)
                        .background(Color("Primary"))
                        .cornerRadius(60.0, corners: [.topLeft, .topRight])
                        .frame(maxWidth: .infinity, alignment: .top)
                        
                    
                    VStack  {
                        
                        Text("第\(taskManager.currentTask.Current_iter)/\(taskManager.currentTask.Total_iter)輪")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .top)
                        Text("\(taskManager.currentTask.taslitems[taskManager.currentMissionIndex].id) 第\(taskManager.current_click+1)/\(taskManager.currentTask.taslitems[taskManager.currentMissionIndex].click)次")
                            .font(.system(size: 30))
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .top)
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                    } .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                   Spacer()
                    
                    
                }  .padding(.top)
                    .padding(.horizontal)
                    .background(Color("Primary"))
                    .cornerRadius(60.0, corners: [.topLeft, .topRight])
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .edgesIgnoringSafeArea(.bottom)
                
                
            }
            .navigationBarBackButtonHidden(true)
//            .navigationTitle(taskid)
                .navigationBarItems(leading: BackButton(action: {
                    for i in 0...dataManager.tasks.count-1{
                        if dataManager.tasks[i].id==taskid{
                            dataManager.tasks[i] = taskManager.currentTask
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }))
            .onReceive(taskManager.$isMissionComplete) { missionComplete in
                if missionComplete {
                    clickCount = 0 // Reset the click count
                }
            }
            
        } else {
            SummaryView(taskManager: taskManager)
            
        }
    }
}


struct DescriptView: View {
    @EnvironmentObject var dataManager: DataManager
    let task:Task
    let tid:String
    @State private var refreshID = UUID()
    var body: some View {
        VStack (alignment: .leading) {
            //                Title
            HStack{
                if let index = dataManager.tasks.firstIndex(where: { $0.id == tid }) {
                    Text("\(dataManager.tasks[index].Completeness)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                }
            }
            
           
           
           
        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
        
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


struct YouTubePlayerView: UIViewRepresentable {
    var videoID: String
    var isPlaying: Bool

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        let request = URLRequest(url: youtubeURL)
        uiView.load(request)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: YouTubePlayerView

        init(_ parent: YouTubePlayerView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            let playScript = """
            var player = document.querySelector('iframe');
            if (player) {
                if (\(parent.isPlaying)) {
                    player.contentWindow.postMessage('{"event":"command","func":"playVideo","args":""}', '*');
                } else {
                    player.contentWindow.postMessage('{"event":"command","func":"pauseVideo","args":""}', '*');
                }
            }
            """
            
            webView.evaluateJavaScript(playScript, completionHandler: nil)
        }
    }
}
