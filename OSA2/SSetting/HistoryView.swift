import SwiftUI


enum TimeScale: String, CaseIterable, Identifiable {
    case day = "日"
    case month = "月"
    case year = "年"
    
    var id: String { self.rawValue }
}
// Assuming you have some model to represent your data:

struct HistorywwView: View {
    @State private var selectedScale: TimeScale = .day
    
    var body: some View {
        VStack(spacing: 0) { // 減少 VStack 內的元件間距
            Picker("Time Scale", selection: $selectedScale) {
                ForEach(TimeScale.allCases) { scale in
                    Text(scale.rawValue).tag(scale)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal) // 僅於水平方向增加 padding

            TabView(selection: $selectedScale) {
                Day_View().tag(TimeScale.day)
                MonthlyView().tag(TimeScale.month)
                YearlyView().tag(TimeScale.year)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxHeight: .infinity) // 允許 TabView 佔據更多空間
        }
        .padding(.top, 10) // 在最頂部添加一點間距
    }
}
struct HistoryView: View {
    @State private var selectedScale: TimeScale = .day
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            // Custom top bar
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                    .padding()
                }

                Spacer()

                

                Spacer()
                
                // Spacer or Invisible button for symmetry
                Button(action: {}) {
                    Image(systemName: "chevron.left").opacity(0)
                }
                .disabled(true)
                .padding()
            }
            
            // Your other content...
            
            Picker("Time Scale", selection: $selectedScale) {
                ForEach(TimeScale.allCases) { scale in
                    Text(scale.rawValue).tag(scale)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.vertical, 8) // You can adjust vertical padding here

            TabView(selection: $selectedScale) {
                // Your tab views here
                Day_View().tag(TimeScale.day)
                MonthlyView().tag(TimeScale.month)
                YearlyView().tag(TimeScale.year)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarHidden(true) // Hide the default navigation bar
    }
}


struct Day_View: View {
    @State private var date = Date()
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    var body: some View {
        VStack {
            HStack{
                Spacer()
                DatePicker(
                    "",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .labelsHidden()
//                .colorInvert()
//                .colorMultiply(.white)
                Spacer()
            }
            Spacer()
           
            //            Text(dataManager.DayHistory[0].id)
            //            Text(formattedDate)
            HStack(spacing:16){
                if let selectedDay = dataManager.DayHistory.first(where: { $0.id == formattedDate }) {
                    
                    ForEach(selectedDay.tasks) { task in
                        
                        
//==================================verticle ver (couldn't align top)=====================================================================================================================
//                        VStack {
//                            ZStack(alignment: .bottom) {
//                                // Background of the bar (grey capsule)
//                                Capsule()
//                                    .frame(width: 30, height: 200)
//                                    .foregroundColor(Color.gray.opacity(0.2))
//
//                                // Foreground of the bar (colored capsule)
//                                Capsule()
//                                    .frame(width: 30, height: CGFloat(task.Completeness) * 2)
//                                    .foregroundColor(task.Completeness > 50 ? Color.blue : Color.purple)
//
//                                // Percentage label above the bar
//                                Text("\(task.Completeness)%")
//                                    .foregroundColor(.black)
//                                    .font(.system(size: 12)) // Adjust the font size as needed
//                                    .lineLimit(1)
//                                    .padding([.bottom, .horizontal], 4) // Provide padding to ensure the label does not stick to the edges of the bar
//                            }
//                            .frame(width: 40, height: 220) // Set the frame for the ZStack to ensure proper spacing
//                            .padding(.top,4)
//
//                            // Task ID label below the bar displayed vertically
//                            VStack(spacing: 0) {
//                                ForEach(Array(task.id), id: \.self) { char in
//                                    Text(String(char))
//                                        .foregroundColor(.black)
//                                        .font(.system(size: 12)) // Adjust the font size as needed
//                                        .lineLimit(1)
//                                }
//                            }
//                            .frame(width: 40) // Set the frame width to match the bar's width
//                            .padding(.top, 4) // Add padding to the top to ensure it doesn't overlap with the bar
//                        }
//                        .frame(width: 50, height: 250) // Set an outer frame for the VStack to ensure proper spacing and alignment
//                        .padding(.top,4)
                        
//==================================verticle ver (couldn't align top)=====================================================================================================================
                        VStack {
                            ZStack(alignment: .bottom) {
                                // Background of the bar (grey capsule)
                                Capsule()
                                    .frame(width: 30, height: 200)
                                    .foregroundColor(Color.gray.opacity(0.2))

                                // Foreground of the bar (colored capsule)
                                Capsule()
                                    .frame(width: 30, height: CGFloat(task.Completeness) * 2)
                                    .foregroundColor(task.Completeness > 50 ? Color.blue : Color.purple)

                                // Percentage label above the bar
                                Text("\(task.Completeness)%")
                                    .foregroundColor(.black)
                                    .font(.system(size: 12)) // Adjust the font size as needed
                                    .lineLimit(1)
                                    .padding([.bottom, .horizontal], 4) // Provide padding to ensure the label does
                            }
                            .frame(width: 40, height: 220)
                            // Task ID label below the bar
                            Text(task.id)
                                .foregroundColor(.black)
                                .font(.system(size: 12)) // Adjust the font size as needed
                                .lineLimit(1)
                                .frame(width: 40) // Ensure the frame matches the bar's width for alignment
                                .padding(.top, 4) // Provide padding to ensure the label is not too close to the bar
                        }
                        .frame(width: 40, height: 250)
                        
                    }
                } else {
                    Text("本日尚無資料")
                }
            }
            
            Spacer()
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {
            presentationMode.wrappedValue.dismiss()
            dataManager.isbarshow = true
        }))
    }

    private var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}






//==================================below is month===================================================




struct YearMonthDay {
    let year: Int
    let month: Int
    let day: Int
}

struct MonthlyView: View {
    // Some arbitrary data for demonstration
    let data: [Double] = [20, 40, 60, 80, 100]
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    let years: [Int] = (2023...2024).map { $0 }
    let months: [String] = DateFormatter().shortMonthSymbols
    
    var body: some View {
        VStack {
            // Year and Month Picker
            HStack {
                Picker("Year", selection: $selectedYear) {
                    ForEach(years, id: \.self) { year in
                        Text("\(year)").tag(year)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(months[month - 1]).tag(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    // Other content...

                    ForEach(uniqueTaskIDs(in: dataManager.DayHistory, forYear: selectedYear, andMonth: selectedMonth), id: \.self) { taskID in
                        VStack {
                            Text(taskID) // Task ID label

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    let daysCount = getDaysInMonth(year: selectedYear, month: selectedMonth)
                                    let barWidth = UIScreen.main.bounds.width / CGFloat(daysCount) // Calculate the width for each bar
                                    
                                    ForEach(1...daysCount, id: \.self) { day in
                                        BarView(value: Double(getComp(for: taskID, in: dataManager.DayHistory, forYear: selectedYear, andMonth: selectedMonth, andDay: day) ?? 0), label: "\(day)", maxWidth:  UIScreen.main.bounds.width / 30)
                                    }
                                }
                            }
                        }
                    }
                }
            }



        }
    }
    func getComp(for taskId: String, in dayHistory: [Day], forYear year: Int, andMonth month: Int, andDay day: Int) -> Int? {
        // Construct a string that represents the full date (e.g., "2023-11-01")
        let datePrefix = String(format: "%04d-%02d-%02d", year, month, day)
        
        // Find the day that matches the datePrefix
        guard let dayData = dayHistory.first(where: { $0.id == datePrefix }) else {
            return nil // No data for this day
        }
        
        // Find the task that matches the taskId
        let taskData = dayData.tasks.first(where: { $0.id == taskId })
        
        // Return the completeness value if the task is found
        return taskData?.Completeness
    }


    // Extract unique task IDs
    func uniqueTaskIDs(in dayHistory: [Day], forYear year: Int, andMonth month: Int) -> [String] {
        // Construct a string that represents the year and month (e.g., "2023-11")
        let yearMonthPrefix = String(format: "%04d-%02d", year, month)
        
        // Filter the dayHistory to include only those entries that start with the yearMonthPrefix
        let filteredDays = dayHistory.filter { $0.id.starts(with: yearMonthPrefix) }
        
        // Extract the task IDs from the filtered days and remove duplicates
        let taskIDs = Set(filteredDays.flatMap { $0.tasks.map { $0.id } })
        
        // Return the unique task IDs
        return Array(taskIDs)
    }

    // Function to determine the number of days in the selected month
    func getDaysInMonth(year: Int, month: Int) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Set the first day of the week to Monday
        let dateComponents = DateComponents(year: year, month: month)
        guard let date = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in:.month, for: date) else {
                return 0
                }
        return range.count
    }
}
struct BarView: View {
    var value: Double
    var label: String
    var maxWidth: CGFloat
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width: maxWidth, height: 100)
                    .foregroundColor(Color.gray.opacity(0.2))
                Capsule().frame(width: maxWidth, height: CGFloat(value * 1))
                    .foregroundColor(value > 50 ? Color.blue : Color.purple)
            }
            Text(label).font(.caption)
        }
    }
}
//==================================below is year===================================================

struct YearlyView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    let years: [Int] = (2023...2024).map { $0 }
    
    var body: some View {
        VStack {
            // Year Picker
            Picker("Year", selection: $selectedYear) {
                ForEach(years, id: \.self) { year in
                    Text("\(year)").tag(year)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    // Iterate over each unique task ID
                    ForEach(uniqueTaskIDs(in: dataManager.DayHistory, forYear: selectedYear), id: \.self) { taskId in
                        VStack {
                            Text(taskId) // Task ID label

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(1...12, id: \.self) { month in
                                        let averageCompleteness = averageComp(for: taskId, year: selectedYear, month: month)
                                        BarView(value: Double(averageCompleteness), label: "\(month)", maxWidth: UIScreen.main.bounds.width / 16)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Calculate the average completeness for a given taskId in a specific year and month
    func averageComp(for taskId: String, year: Int, month: Int) -> Int {
        // Filter the history for the specified year and month
        let monthEntries = dataManager.DayHistory.filter {
            $0.id.hasPrefix("\(year)-\(String(format: "%02d", month))")
        }
        
        // Calculate the total completeness and count the number of entries
        let totalCompleteness = monthEntries.reduce(0) { (result, day) in
            result + (day.tasks.first { $0.id == taskId }?.Completeness ?? 0)
        }
        
        // Count the number of entries where the task ID matches and has completeness
        let count = monthEntries.filter { day in
            day.tasks.contains(where: { $0.id == taskId && $0.Completeness != nil })
        }.count

        // Calculate the average, avoiding division by zero
        return count > 0 ? totalCompleteness / count : 0
    }


    // Extract unique task IDs for a given year
    func uniqueTaskIDs(in dayHistory: [Day], forYear year: Int) -> [String] {
        let yearPrefix = "\(year)-"
        let filteredDays = dayHistory.filter { $0.id.starts(with: yearPrefix) }
        let taskIDs = Set(filteredDays.flatMap { $0.tasks.map { $0.id } })
        return Array(taskIDs)
    }
    
    // Function to determine the number of days in the selected month
    func getDaysInMonth(year: Int,month: Int) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Set the first day of the week to Monday
        let dateComponents = DateComponents(year: year, month: month)
        guard let date = calendar.date(from: dateComponents),
        let range = calendar.range(of: .day, in: .month, for: date) else {
        return 0
        }
        return range.count
    }
}
