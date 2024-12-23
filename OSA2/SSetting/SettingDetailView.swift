import SwiftUI

struct SettingDetailView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State private var inactivityHours: Int = 0
    @State private var dailyReminderTime: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("久未使用提醒")) {
                Stepper(value: $inactivityHours, in: 1...24) {
                    Text("離開 \(inactivityHours) 小時將會提醒")
                }
                .onChange(of: inactivityHours) { newValue in
                    dataManager.inactivityHours = newValue
                    dataManager.saveData()
                }
            }
            
            Section(header: Text("每日提醒時間")) {
                DatePicker("Reminder Time", selection: $dailyReminderTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .onChange(of: dailyReminderTime) { newDate in
                        let calendar = Calendar.current
                        let hour = calendar.component(.hour, from: newDate)
                        let minute = calendar.component(.minute, from: newDate)
                        
                        dataManager.dailyReminderHour = hour
                        dataManager.dailyReminderMinute = minute
                        scheduleDailyReminder()
                        dataManager.saveData()
                    }
            }
            
            Section(header: Text("壓力門檻")) {
                Slider(value: Binding(
                    get: { Double(dataManager.PressureThreshold) },
                    set: { dataManager.PressureThreshold = Int($0); dataManager.saveData() }
                ), in: 10...100, step: 1) {
                    // You can provide a label here if needed
                    Text("Adjust the Volume")
                }

                // Display the current value as text
                Text("壓力門檻值: \(dataManager.PressureThreshold)")
            }

        }
        .navigationTitle("Settings")
        .onAppear {
            // Initialize view state from DataManager
            inactivityHours = dataManager.inactivityHours
            
            var components = DateComponents()
            components.hour = dataManager.dailyReminderHour
            components.minute = dataManager.dailyReminderMinute
            if let reminderDate = Calendar.current.date(from: components) {
                dailyReminderTime = reminderDate
            }
        }
        .onDisappear{
//            scheduleDailyReminder()
        }
    }
    func scheduleDailyReminder() {
        // First, remove any previously scheduled daily reminders
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["DailyReminder"])
        
        let hour = dataManager.dailyReminderHour
        let minute = dataManager.dailyReminderMinute
        
        // Decide on the greeting based on the scheduled time
        let greeting: String
        if hour < 12 {
            greeting = "早安！"  // Good morning
        } else if hour < 18 {
            greeting = "午安！"  // Good afternoon
        } else {
            greeting = "晚安！"  // Good evening
        }

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let content = UNMutableNotificationContent()
        content.title = greeting
        content.body = "來上課吧！讓我們一起創造美好的未來！"
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "DailyReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling daily reminder: \(error.localizedDescription)")
            } else {
                print("Daily reminder scheduled to fire every day at \(hour):\(minute) with title: \(greeting)")
            }
        }
    }

}

struct SettingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingDetailView()
            .environmentObject(DataManager())
    }
}
