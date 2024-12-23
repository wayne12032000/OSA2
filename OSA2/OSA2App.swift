//
//  OSA2App.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/20.
//

//import SwiftUI
//
//@main
//struct OSA2App: App {
//    @StateObject private var dataManager = DataManager()
//    var body: some Scene {
//        WindowGroup {
//            
//                ContentView().environmentObject(dataManager)
//            
//           
//        }
//    }
//}
import SwiftUI
import UserNotifications
@main
struct OSA2App: App {
    @AppStorage("hasSeenWalkthrough") var hasSeenWalkthrough: Bool = false
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var dataManager = DataManager()
    @State private var isLogin = false

    var body: some Scene {
        WindowGroup {
            if hasSeenWalkthrough {
                ContentView().environmentObject(dataManager)
                    .onAppear {
                       // 请求通知权限
                       UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                           if granted {
                               print("通知权限已授予")
                           } else {
                               print("通知权限被拒绝")
                           }
                       }
                   }
            } else {
               WalkthroughView(
                   slides: [
                    WalkthroughSlide(imageName: "s12", description: ""),
                    WalkthroughSlide(imageName: "s1", description: ""),
                    WalkthroughSlide(imageName: "s2", description: ""),
                    WalkthroughSlide(imageName: "s3", description: ""),
                    
                    WalkthroughSlide(imageName: "s4", description: ""),
                    WalkthroughSlide(imageName: "s5", description: ""),
                    WalkthroughSlide(imageName: "s6", description: ""),
                    
                    WalkthroughSlide(imageName: "s7", description: ""),
                    WalkthroughSlide(imageName: "s8", description: ""),
                    WalkthroughSlide(imageName: "s9", description: ""),
                    
                    WalkthroughSlide(imageName: "s10", description: ""),
                    WalkthroughSlide(imageName: "s11", description: ""),
                    WalkthroughSlide(imageName: "s12", description: ""),
                    
                    WalkthroughSlide(imageName: "s13", description: ""),
                    WalkthroughSlide(imageName: "s14", description: ""),
                    WalkthroughSlide(imageName: "s15", description: ""),
                    
                    WalkthroughSlide(imageName: "s16", description: ""),
                    WalkthroughSlide(imageName: "s17", description: ""),
                    WalkthroughSlide(imageName: "s18", description: ""),
                    
                    WalkthroughSlide(imageName: "s19", description: ""),
                    WalkthroughSlide(imageName: "s20", description: "")
                   ]
                   
               ).onDisappear{
                   hasSeenWalkthrough = true // Mark walkthrough as seen
               }
               .onAppear {
                  // 请求通知权限
                  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                      if granted {
                          print("通知权限已授予")
                      } else {
                          print("通知权限被拒绝")
                      }
                  }
              }
            }
        }
    }
}

//            ContentView().environmentObject(dataManager)
//                .onAppear {
//                                    // 请求通知权限
//                                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
//                                        if granted {
//                                            print("通知权限已授予")
//                                        } else {
//                                            print("通知权限被拒绝")
//                                        }
//                                    }
//                                }
//            
            
            
            
            
            
//            if !dataManager.isLogin{
//                
//                
//                LoginRegisterView().environmentObject(dataManager)
// 
//            } else {
//                ContentView().environmentObject(dataManager)
//            }



//                IntroView()
//                    .onAppear {
//                        // Show IntroView for 3 seconds
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                            // Hide IntroView after 3 seconds
//                            showIntroView = false
//                        }
//                    }
class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // 应用在前台时收到通知
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }

    // 用户点击通知时调用
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler:
                                @escaping () -> Void) {
        // 在这里处理通知点击事件，例如导航到特定的视图
        completionHandler()
    }
}
