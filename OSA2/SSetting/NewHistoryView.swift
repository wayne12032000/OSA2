//
//  NewHistoryView.swift
//  OSA2
//
//  Created by Sheng-Fu Liang on 2024/12/11.
//

import SwiftUI
import SwiftUI

class CalendarManager: ObservableObject {
    @Published var currentDate: Date = Date()

    func incrementMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }

    func daysInMonth() -> [Date] {
        guard let range = Calendar.current.range(of: .day, in: .month, for: currentDate),
              let firstDay = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: currentDate)) else {
            return []
        }

        return range.compactMap { Calendar.current.date(byAdding: .day, value: $0 - 1, to: firstDay) }
    }
}

struct CalendarView: View {
    @ObservedObject var calendarManager = CalendarManager()

    private let daysOfWeek = ["日", "一", "二", "三", "四", "五", "六"]

    var body: some View {
        VStack {
            // Navigation Bar
            HStack {
                Button(action: { calendarManager.incrementMonth(by: -1) }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(currentMonthYear())
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: { calendarManager.incrementMonth(by: 1) }) {
                    Image(systemName: "chevron.right")
                }
            }
            .padding()

            // Days of the Week
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                }
            }

            // Calendar Grid
            let days = calendarManager.daysInMonth()
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(days, id: \.self) { date in
                    Button(action: { dayTapped(date) }) {
                        Text("\(Calendar.current.component(.day, from: date))")
                            .font(.body)
                            .frame(width: 40, height: 40)
                            .background(Circle().stroke(Color.blue))
                    }
                }
            }
            Spacer()
        }
        .padding()
    }

    private func currentMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 MM月"
        return formatter.string(from: calendarManager.currentDate)
    }

    private func dayTapped(_ date: Date) {
        print("Selected Date: \(date)")
        // Handle date selection
    }
}
import SwiftUI

struct NewHistoryView: View {
    @ObservedObject var calendarManager = CalendarManager()
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // Example tasks data associated with dates
    @State private var temdata:[Day] = [
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

    @State private var selectedTasks: [Task] = []

        var body: some View {
//            NavigationStack {
                VStack {
                    
                    // Navigation Bar for Month
                    HStack {
                        Button(action: { calendarManager.incrementMonth(by: -1) }) {
                            Image(systemName: "chevron.left")
                        }
                        Spacer()
                        Text(currentMonthYear())
                            .font(.title)
                            .bold()
                        Spacer()
                        Button(action: { calendarManager.incrementMonth(by: 1) }) {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .padding()

                    // Days of the Week Header
                    HStack {
                        ForEach(["日", "一", "二", "三", "四", "五", "六"], id: \.self) { day in
                            Text(day)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                        }
                    }

                    // Calendar Grid
                    let days = calendarManager.daysInMonth()
                    let leadingEmptyDays = leadingEmptyDaysCount(for: days.first)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                        // Add empty items for leading days
                        ForEach(0..<leadingEmptyDays, id: \.self) { _ in
                            Text("") // Empty space
                                .frame(width: 40, height: 40)
                        }

                        // Add days of the month
                        ForEach(days, id: \.self) { date in
                            NavigationLink(destination: DetailHistoryOfDayView(tasks: tasksForDate(date),selectedDate: date )) {
                                Text("\(Calendar.current.component(.day, from: date))")
                                    .font(.body)
                                    .frame(width: 40, height: 40)
                                    .background(Circle().stroke(isDayWithTasks(date) ? Color.green : Color.white))
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
            .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton2(action: {
                    presentationMode.wrappedValue.dismiss()
                   
                }))
        }

        private func currentMonthYear() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年 MM月"
            return formatter.string(from: calendarManager.currentDate)
        }

        private func tasksForDate(_ date: Date) -> [Task] {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = formatter.string(from: date)

            // Find tasks for the selected day
            return dataManager.DayHistory.first(where: { $0.id == selectedDate })?.tasks ?? []
        }

        private func isDayWithTasks(_ date: Date) -> Bool {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let dateString = formatter.string(from: date)

            return dataManager.DayHistory.contains(where: { $0.id == dateString })
        }

        private func leadingEmptyDaysCount(for firstDate: Date?) -> Int {
            guard let firstDate = firstDate else { return 0 }
            let weekday = Calendar.current.component(.weekday, from: firstDate) // Sunday = 1
            return (weekday - 1) // Adjust to match the starting weekday (Monday = 0 for this example)
        }
    }

struct BackButton2: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(.white)
                .cornerRadius(8.0)
        }
    }
}


#Preview {
    NewHistoryView()
}
