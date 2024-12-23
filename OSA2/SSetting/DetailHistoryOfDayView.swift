//
//  DetailHistoryOfDayView.swift
//  OSA2
//
//  Created by Sheng-Fu Liang on 2024/12/11.
//

import SwiftUI

import SwiftUI
import SwiftUI
import Charts

struct DetailHistoryOfDayView: View {
    var tasks: [Task]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedTaskIndex: Int = 0
    var reversedTasks: [Task] {
        return tasks.reversed()
    }
    var selectedDate: Date

        var body: some View {
            VStack {
                // Display the selected date
                Text(formattedDate(selectedDate))
                    .font(.title)
                    .bold()
                    .padding()


            // Tab View for Tasks
                TabView(selection: Binding(
                        get: { tasks.count - 1 - selectedTaskIndex },
                        set: { newValue in selectedTaskIndex = tasks.count - 1 - newValue }
                    )) {
                        ForEach(Array(tasks.enumerated()), id: \.offset) { index, task in
                            DTaskDetailView(task: task)
                                .tag(index)
                        }
                    }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .onAppear {
                    UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.systemBlue // Set the current dot color
                    UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray // Set the other dots' color
                }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton2(action: {
                presentationMode.wrappedValue.dismiss()
               
            }))

            Spacer()
        }
        .padding()
        }
    
    // Helper function to format the date
        func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy MM d, EE" // Example: "2024, Dec 5, Wednesday"
            return formatter.string(from: date)
        }
}
struct DTaskDetailView: View {
    var task: Task

    var body: some View {
        VStack(alignment: .center) {
            Text("\(task.id) \(task.Completeness)%")
                .font(.headline)
                .padding(.bottom)

            ScrollView {
                ForEach(task.taslitems, id: \.id) { mission in
                    MissionDetailView(mission: mission)
                        .padding(.bottom)
                }
            }
        }
        .padding()
    }
}
struct MissionDetailView: View {
    var mission: Mission

    var body: some View {
        VStack(alignment: .leading) {
            Text("任務:\(mission.id)")
                .font(.headline)
                .padding(.bottom)

            LineChartView(pressureData: mission.pressure_data)
                .frame(height: 200)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

struct BarChartView: View {
    var pressureData: [Pressure_one_time]

    var body: some View {
        Chart {
            ForEach(Array(pressureData.enumerated()), id: \.offset) { index, data in
                ForEach(Array(data.P.enumerated()), id: \.offset) { i, value in
                    BarMark(
                        x: .value("Index", i),
                        y: .value("Value", value)
                    )
                    .foregroundStyle(by: .value("Pressure Set", "Set \(index + 1)"))
                }
            }
        }
        .chartLegend(.visible)
        .chartXAxis {
            AxisMarks(position: .bottom)
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
    }
}
import SwiftUI
import Charts
import SwiftUI
import Charts
import SwiftUI
import Charts
struct LineChartView: View {
    var pressureData: [Pressure_one_time]
    @State private var showLine: [Bool]

    init(pressureData: [Pressure_one_time]) {
        self.pressureData = pressureData
        _showLine = State(initialValue: Array(repeating: true, count: pressureData.count)) // Default: all lines shown
    }

    var body: some View {
        VStack {
            Chart {
                ForEach(Array(pressureData.enumerated()), id: \.offset) { index, data in
                    let datasetName = "Set \(index + 1)"
                    
                    // Only draw the line and points if showLine[index] is true
                    if showLine[index] {
                        ForEach(Array(data.P.enumerated()), id: \.offset) { i, value in
                            LineMark(
                                x: .value("Index", i),
                                y: .value("Value", value)
                            )
                            .foregroundStyle(by: .value("Pressure Set", datasetName))
                            
                            PointMark(
                                x: .value("Index", i),
                                y: .value("Value", value)
                            )
                            .symbol(Circle())
                            .symbolSize(10)
                            .foregroundStyle(by: .value("Pressure Set", datasetName))
                        }
                    }
                }
            }
            .chartLegend(.visible)
            .chartXAxis {
                AxisMarks(position: .bottom)
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartXScale(domain: 0...10)
            .frame(maxWidth: .infinity, maxHeight: 300)
            .padding()

            HStack {
                ForEach(Array(pressureData.enumerated()), id: \.offset) { index, data in
                    VStack {
                        Button(action: {
                            // Toggle the visibility of this dataset's line
                            showLine[index].toggle()
                        }) {
                            Text("Set \(index + 1)")
                                .font(.caption)
                                .padding(8)
                                .background(showLine[index] ? Color.blue.opacity(0.7) : Color.gray.opacity(0.3))
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                        
                        // Calculate the average for this set
                        let avg = data.P.isEmpty ? 0 : data.P.map { Double($0) }.reduce(0, +) / Double(data.P.count)

                        Text("平均: \(avg, specifier: "%.2f")")
                            .font(.caption)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}




#Preview {
    DetailHistoryOfDayView(tasks: [
        Task(
            id: "TestTask0",
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
            id: "TestTask1",
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
    ], selectedDate: Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 25))!
    )
}

