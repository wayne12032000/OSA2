//
//  ContentView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelected: Tab = .lessons
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.scenePhase) var scenePhase
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if tabSelected == .lessons {
                        // 显示“課程”视图
                        PersonView()
                    } else if tabSelected == .settings {
                        // 显示“設定”视图
                        SettingView()
                    }
                }
                if dataManager.isbarshow {
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $tabSelected)
                            .frame(alignment: .bottom)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // 应用程序即将进入非活动状态，保存数据
            dataManager.saveData()
        }
        .onChange(of: scenePhase) { newPhase in
                        if newPhase == .active {
                            // App became active, cancel inactivity reminder
                            cancelInactivityReminder()
                        } else if newPhase == .background {
                            // App entered background, schedule inactivity reminder
                            scheduleInactivityReminder()
                        }
                    }
                    .onAppear {
                        // Schedule daily reminder when the app starts
                        scheduleDailyReminder()
                    }
                    .navigationBarHidden(true) // Hides the navigation bar
                
    }
    
    
   
    // Inactivity Reminder Notification (fires after 4 hours of inactivity)
        func scheduleInactivityReminder() {
            let content = UNMutableNotificationContent()
            content.title = "我們想念您！"
            content.body = "您已經有一段時間没有打開應用了，快回来看看吧！"
            content.sound = UNNotificationSound.default

            // Schedule to fire after 4 hours (non-repeating)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(dataManager.inactivityHours*3600), repeats: false)

            let request = UNNotificationRequest(identifier: "InactivityReminder", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling inactivity reminder: \(error.localizedDescription)")
                } else {
                    print("Inactivity reminder scheduled to fire after \(dataManager.inactivityHours) hours.")
                }
            }
        }

        func cancelInactivityReminder() {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["InactivityReminder"])
            print("Inactivity reminder canceled.")
        }

        // Daily Reminder Notification (fires every day at 8 AM)
    func scheduleDailyReminder() {
        // First, remove any previously scheduled daily reminders
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DailyReminder"])
        
        let content = UNMutableNotificationContent()
        content.title = "早安！"
        content.body = "來上課吧！讓我們一起創造美好的未來！"
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = dataManager.dailyReminderHour
        dateComponents.minute = dataManager.dailyReminderMinute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "DailyReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling daily reminder: \(error.localizedDescription)")
            } else {
                print("Daily reminder scheduled to fire every day at \(dataManager.dailyReminderHour):\(dataManager.dailyReminderMinute).")
            }
        }
    }

}


#Preview {
    ContentView()
}
