

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    static let shared = BLEManager() // Shared instance
    @Published var isConnected = false
    @Published var connectionFailed = false
    @Published var time: String = ""
    @Published var pressure: String = ""
    @Published var timecount: Int = 0
    

    private var centralManager: CBCentralManager!
    private var connectedPeripheral: CBPeripheral?
    private var targetCharacteristic: CBCharacteristic?

    // UUIDs for the service and characteristic
    let targetServiceUUID = CBUUID(string: "12345678-1234-1234-1234-123456789012")
    let targetCharacteristicUUID = CBUUID(string: "87654325-4321-4321-4321-210987654325")

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("BLE is powered on. Starting auto-connect.")
            autoConnect()
        } else {
            print("BLE is not available.")
            isConnected = false
        }
    }

    func startScanning() {
        if centralManager.state == .poweredOn {
            print("Scanning for peripherals...")
            centralManager.scanForPeripherals(withServices: [targetServiceUUID], options: nil)
        }
    }

   
    
    func autoConnect() {
        // Ensure the previous states are cleaned up
        connectionFailed = false
        isConnected = false

        // Cancel existing connection if needed
        if let peripheral = connectedPeripheral {
            centralManager.cancelPeripheralConnection(peripheral)
            clearPeripheralCache(peripheral)
        }

        // Reset peripheral and characteristic references
        connectedPeripheral = nil
        targetCharacteristic = nil

        // Start scanning after a short delay to allow cleanup
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.startScanning()
        }
    }

    func disconnect() {
        guard let peripheral = connectedPeripheral else {
            print("No connected peripheral to disconnect")
            return
        }

        if let characteristic = targetCharacteristic {
            peripheral.setNotifyValue(false, for: characteristic) // Stop notifications
        }

        centralManager.cancelPeripheralConnection(peripheral)
        connectedPeripheral = nil
        targetCharacteristic = nil
        isConnected = false

        print("Disconnected and cleaned up peripheral references.")
    }


    func resetCentralManager() {
        print("Resetting central manager...")
        centralManager.delegate = nil
        centralManager.stopScan()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        connectedPeripheral = nil
        targetCharacteristic = nil
        isConnected = false
        connectionFailed = false
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        print("Discovered peripheral: \(peripheral.name ?? "Unknown Device")")
        centralManager.stopScan()

        if connectedPeripheral != peripheral {
            connectedPeripheral = peripheral
            connectedPeripheral?.delegate = self
            centralManager.connect(peripheral, options: nil)
        } else {
            print("Reconnecting to known peripheral.")
            connectedPeripheral?.delegate = self
            centralManager.connect(peripheral, options: nil)
        }
    }



    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: \(peripheral.name ?? "Unknown Device")")
        isConnected = true
        connectionFailed = false
        peripheral.discoverServices([targetServiceUUID])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to peripheral: \(peripheral.name ?? "Unknown Device"). Error: \(error?.localizedDescription ?? "Unknown error")")
        connectionFailed = true
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from peripheral: \(peripheral.name ?? "Unknown Device")")
        isConnected = false

        // Clear old references
        clearPeripheralCache(peripheral)

        // Attempt reconnection only if needed
        if UIApplication.shared.applicationState == .active {
//            startReconnection()
            self.autoConnect()
        }
    }
    func clearPeripheralCache(_ peripheral: CBPeripheral) {
        if let characteristic = targetCharacteristic {
            peripheral.setNotifyValue(false, for: characteristic) // Stop notifications
        }
        connectedPeripheral = nil
        targetCharacteristic = nil
        print("Cleared peripheral cache.")
    }




    


    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            if service.uuid == targetServiceUUID {
                print("Discovered target service.")
                peripheral.discoverCharacteristics([targetCharacteristicUUID], for: service)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.uuid == targetCharacteristicUUID {
                print("Discovered target characteristic.")
                targetCharacteristic = characteristic
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let data = characteristic.value else { return }
        if let utf8String = String(data: data, encoding: .utf8) {
            print("Received data: \(utf8String)")
            parseData(utf8String)
        }
    }

    private func parseData(_ data: String) {
        if let timeRange = data.range(of: "T:"),
           let pressureRange = data.range(of: "P:") {
            let timeSubstring = data[timeRange.upperBound...].split(separator: ",").first ?? ""
            let pressureSubstring = data[pressureRange.upperBound...].split(separator: ",").first ?? ""
            DispatchQueue.main.async {
                self.time = String(timeSubstring)
                self.pressure = String(pressureSubstring)
            }
        }
    }

    private func startReconnection() {
        print("Attempting reconnection in 3 seconds...")
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { // Adjust delay
            self.autoConnect()
        }
    }

}

import SwiftUI
import UIKit
import WebKit

class YouTubePlayerViewModel: ObservableObject {
    let webView: WKWebView
    @Published var videoID: String {
        didSet {
            if oldValue != videoID {
                loadVideo()
            }
        }
    }

    init(videoID: String) {
        self.videoID = videoID

        // Initialize webView
        let contentController = WKUserContentController()

        // JavaScript code to disable full-screen functionality
        let scriptSource = """
        // Hide the full-screen button
        var css = '.ytp-fullscreen-button { display: none !important; }';
        var style = document.createElement('style');
        style.type = 'text/css';
        style.appendChild(document.createTextNode(css));
        document.head.appendChild(style);
        """

        // Inject the JavaScript into the web view
        let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(script)

        // Create a WKWebViewConfiguration and assign the content controller
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // 允许自动调整尺寸

        loadVideo()
    }

    private func loadVideo() {
        let htmlString = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
            <style>
                html, body {
                    margin: 0;
                    padding: 0;
                    width: 100%;
                    height: 100%;
                    overflow: hidden;
                    background-color: black;
                }
                .video-container {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                }
                iframe {
                    width: 100%;
                    height: 100%;
                    border: none;
                }
            </style>
        </head>
        <body>
            <div class="video-container">
                <iframe src="https://www.youtube.com/embed/\(videoID)?playsinline=1&rel=0&fs=0&autoplay=1&modestbranding=1&controls=1"
                        frameborder="0"
                        allow="autoplay; encrypted-media"
                        allowfullscreen>
                </iframe>
            </div>
        </body>
        </html>
        """

        webView.loadHTMLString(htmlString, baseURL: nil)
    }
}

import SwiftUI
import WebKit

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    @ObservedObject var viewModel: YouTubePlayerViewModel

    func makeUIView(context: Context) -> WKWebView {
        let webView = viewModel.webView
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 不需要更新
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: YouTubePlayerView

        init(_ parent: YouTubePlayerView) {
            self.parent = parent
        }

        // 防止创建新窗口
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                     for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            return nil
        }

        // 其他代理方法（如有需要）
    }
}



import SwiftUI
import UIKit
import WebKit

struct VideoPlayerView: View {
    @ObservedObject var bleManager = BLEManager.shared
    @EnvironmentObject var dataManager: DataManager
    @ObservedObject var taskManager: TaskManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let taskid: String
    
    @StateObject private var youTubePlayerViewModel: YouTubePlayerViewModel
    @State private var clickCount = 0
    @State private var isremindshow = false
    @State private var showCompletionAlert = false
    @State private var isLandscape: Bool = UIScreen.main.bounds.width > UIScreen.main.bounds.height
    
    @State private var pressureArray: [Int] = []
    @State private var TimeArray: [String] = []
    @State private var pressureArrayTemp: [Int] = []
    @State private var TimeArrayTemp: [String] = []
    
    @State private var timer: Timer? = nil
    @State private var pressureTimerActive = false
    @State private var timerCount: Int = 0
    
    @State private var lastNonFlatOrientationIsLandscape: Bool = UIScreen.main.bounds.width > UIScreen.main.bounds.height

    


    init(taskManager: TaskManager, taskid: String) {
        self.taskManager = taskManager
        self.taskid = taskid
        _youTubePlayerViewModel = StateObject(wrappedValue: YouTubePlayerViewModel(videoID: taskManager.currentTask.taslitems[taskManager.currentMissionIndex].url))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Bg").ignoresSafeArea()

                if taskManager.isSummaryViewVisible {
                    SummaryView(taskManager: taskManager, taskid: taskid)
                } else {
                    Group {
                        if isLandscape {
                            // Landscape layout
                            HStack(spacing: 0) {
                                Spacer()
                                videoSection
                                    .frame(width: geometry.size.width * 0.7)
                                    .frame(height: geometry.size.height)
                                Spacer()
                                contentSection
                                    .frame(width: geometry.size.width * 0.3)
                                    .frame(height: geometry.size.height)
                            }
                        } else {
                            // Portrait layout
                            VStack(spacing: 0) {
                                videoSection
                                    .frame(width: geometry.size.width)
                                    .frame(height: geometry.size.height * 0.4)

                                contentSection
                                    .frame(width: geometry.size.width)
                                    .frame(height: geometry.size.height * 0.6)
                            }
                        }
                    }
                    .transition(.slide)
                }
            }
            .onAppear {
                let STime = Date()
                taskManager.currentTask.startTime = STime
                // Only start timer once
                if timer == nil {
                    startMonitoringPressure()
                }
                if !bleManager.isConnected {
                    bleManager.autoConnect()
                }
                youTubePlayerViewModel.videoID = taskManager.currentTask.taslitems[taskManager.currentMissionIndex].url
            }
            .onDisappear {
                // Always stop the timer and disconnect BLE
                stopMonitoringPressure()
                bleManager.disconnect()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: {
                let Ltime = Date()
                taskManager.currentTask.leaveTime = Ltime
                taskManager.initcompleteness()
                taskManager.updateUsingTime()
                updateDayHistory()
                
                presentationMode.wrappedValue.dismiss()
            }))
            .onRotate { newOrientation in
                DispatchQueue.main.async {
                    withAnimation {
                        if newOrientation.isLandscape {
                            isLandscape = true
                            lastNonFlatOrientationIsLandscape = true
                        } else if newOrientation.isPortrait {
                            isLandscape = false
                            lastNonFlatOrientationIsLandscape = false
                        } else {
                            // newOrientation is flat: revert to the last known non-flat orientation
                            isLandscape = lastNonFlatOrientationIsLandscape
                        }
                        // Force webView layout update
                                youTubePlayerViewModel.webView.setNeedsLayout()
                                youTubePlayerViewModel.webView.layoutIfNeeded()
                    }
                }
            }
            .onChange(of: taskManager.currentTask.taslitems[taskManager.currentMissionIndex].url) { newVideoID in
                youTubePlayerViewModel.videoID = newVideoID
            }
            .alert(isPresented: $isremindshow) {
                Alert(
                    title: Text("親愛的用戶！"),
                    message: Text("請跟著影片一起做喔！"),
                    dismissButton: .default(Text("確定"))
                )
            }
            .alert(isPresented: $showCompletionAlert) {
                Alert(
                    title: Text("任務完成！"),
                    message: Text("您已完成所有任務!\n回到首頁看看其他課程吧！"),
                    dismissButton: .default(Text("確定"), action: {
                        let Ltime = Date()
                        taskManager.currentTask.leaveTime = Ltime
                        taskManager.updateUsingTime()
                        updateDayHistory()
                        presentationMode.wrappedValue.dismiss()
                       
                    })
                )
            }
        }
    }

    var videoSection: some View {
        YouTubePlayerView(viewModel: youTubePlayerViewModel)
            .background(Color.black)
            .clipped()
    }

    var contentSection: some View {
        Group {
            if taskManager.currentTask.taslitems[taskManager.currentMissionIndex].type == 0 {
                simpleActionSection
            } else if taskManager.currentTask.taslitems[taskManager.currentMissionIndex].type == 1 {
                pressureActionSection
            }
        }
    }

    var simpleActionSection: some View {
        VStack {
            ZStack {
                CircularProgressView(
                    total: taskManager.currentTask.taslitems[taskManager.currentMissionIndex].click,
                    completed: taskManager.current_click,
                    lineWidth: 15,
                    circleSize: 200,
                    backgroundColor: .gray,
                    foregroundColor: .green
                )
                .padding()

                Button(action: {
                    clickCount += 1
                    taskManager.handleButtonClick()

                    if clickCount % 10 == 0 {
                        isremindshow.toggle()
                    }

                    if taskManager.currentTask.Completeness >= 100 {
                        taskManager.isSummaryViewVisible = true
                        showCompletionAlert = true
                    }
                }) {
                    VStack(spacing:10) {
                        Text("再做一次")
                            .font(.title3)
                            .foregroundColor(Color.black)
                        Text("目前進度: \(taskManager.current_click)/\(taskManager.currentTask.taslitems[taskManager.currentMissionIndex].click)")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(Color("Bg"))
                .cornerRadius(50)
            }
            .padding()
        }
        .background(Color("Bg"))
        .cornerRadius(20)
        .padding()
    }

    var pressureActionSection: some View {
        VStack {
            ZStack {
                CircularProgressView(
                    total: taskManager.currentTask.taslitems[taskManager.currentMissionIndex].click,
                    completed: taskManager.current_click,
                    lineWidth: 15,
                    circleSize: 200,
                    backgroundColor: .gray,
                    foregroundColor: .blue
                )
                .padding()

                Button(action: {
                    clickCount += 1
                    taskManager.handleButtonClick()

                    if clickCount % 10 == 0 {
                        isremindshow.toggle()
                    }

                    if taskManager.currentTask.Completeness >= 100 {
                        taskManager.isSummaryViewVisible = true
                        showCompletionAlert = true
                    }
                }) {
                    VStack(spacing:10) {
                        Text("再做一次")
                            .font(.title3)
                            .foregroundColor(Color.black)

                        Text("目前進度: \(taskManager.current_click)/\(taskManager.currentTask.taslitems[taskManager.currentMissionIndex].click)")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                .background(Color("Bg"))
                .cornerRadius(50)
            }
            .padding()

            VStack(alignment: .center, spacing: 10) {
                Text("維持: \(timerCount) 秒")
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                HStack {
                    Spacer(minLength: 30)
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(pressureColor())
                            .frame(width: CGFloat(clampedPressureValue()) / 100 * geometry.size.width, height: 20)
                            .cornerRadius(5)
                    }
                    .frame(height: 20)
                    Spacer(minLength: 30)
                }
                .frame(maxWidth: .infinity)

                Button(action: {
                    if bleManager.connectionFailed {
                        bleManager.autoConnect()
                    }
                }) {
                    if bleManager.isConnected {
                        Text("Connected ✅")
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                    } else if bleManager.connectionFailed {
                        Text("Retry 🔄")
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                    } else {
                        Text("Connecting...")
                            .foregroundColor(.orange)
                            .fontWeight(.semibold)
                    }
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color("Bg"))
        .cornerRadius(20)
        .padding()
    }

    private func updateDayHistory() {
        let fixdate = Date()
        var formattedDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: fixdate)
        }

        if let existingDayIndex = dataManager.DayHistory.firstIndex(where: { $0.id == formattedDate }) {
            let existingDay = dataManager.DayHistory[existingDayIndex]
            if let existingTaskIndex = existingDay.tasks.firstIndex(where: { $0.id == taskManager.currentTask.id }) {
                dataManager.DayHistory[existingDayIndex].tasks[existingTaskIndex] = taskManager.currentTask.deepCopy()
            } else {
                dataManager.DayHistory[existingDayIndex].tasks.append(taskManager.currentTask.deepCopy())
            }
        } else {
            let dayhistory = Day(id: formattedDate, tasks: [taskManager.currentTask.deepCopy()])
            dataManager.DayHistory.append(dayhistory)
        }
    }

    // MARK: - Pressure Logic
    private func clampedPressureValue() -> Int {
        guard let pressure = Int(bleManager.pressure) else { return 0 }
        return min(max(pressure, 0), 100)
    }

    private func pressureColor() -> Color {
        let pressure = clampedPressureValue()
        return pressure < dataManager.PressureThreshold ? Color.orange : Color.green
    }
    //MARK: 10 hz pressure
    private func startMonitoringPressure() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            guard bleManager.isConnected else { return }

            if let pressure = Int(bleManager.pressure), pressure >= dataManager.PressureThreshold {
                DispatchQueue.main.async {
//                    if self.timerCount == 0 {
//                        self.pressureArray.removeAll()
//                        self.TimeArray.removeAll()
//                        self.pressureArrayTemp.removeAll()
//                        self.TimeArrayTemp.removeAll()
//                    }

                    
                    
                    

                    if self.pressureArray.count >= 10 {
                        print("A p count: \(self.pressureArray.count)")
                        print("A T count: \(self.TimeArray.count)")
                        print("Apt count: \(self.pressureArrayTemp.count)")
                        print("ATt count: \(self.TimeArrayTemp.count)")
                        // Append pressure data only once here
                        taskManager.currentTask.taslitems[taskManager.currentMissionIndex].pressure_data.append(
                            Pressure_one_time(P: self.pressureArray, T: self.TimeArray, iter: taskManager.current_iter)
                        )

                        self.pressureArray.removeAll()
                        self.TimeArray.removeAll()
                        self.pressureArrayTemp.removeAll()
                        self.TimeArrayTemp.removeAll()
                        self.pressureTimerActive = false
                        self.timerCount = 0

                        self.clickCount += 1
                        taskManager.handleButtonClick()

                        if self.clickCount % 10 == 0 {
                            self.isremindshow.toggle()
                        }

                        if taskManager.currentTask.Completeness >= 100 {
                            taskManager.isSummaryViewVisible = true
                            self.showCompletionAlert = true
                        }
                        
                        
                      
                    }else{
                        if self.pressureArrayTemp.count < 5 {
                           
                            self.pressureArrayTemp.append(pressure)
                            self.TimeArrayTemp.append(bleManager.time)
                            print("B p count: \(self.pressureArray.count)")
                            print("B T count: \(self.TimeArray.count)")
                            print("Bpt count: \(self.pressureArrayTemp.count)")
                            print("BTt count: \(self.TimeArrayTemp.count)")
                        }else if self.pressureArrayTemp.count >= 5 {
                           
                            //self.pressureArray.append(avg Pdata)
                            //self.TimeArray.append(avg Tdata)
                            let sum = pressureArrayTemp.reduce(0, +)
                            let averageDouble = Double(sum) / Double(pressureArrayTemp.count)
                            let average = Int(round(averageDouble))
                            self.pressureArray.append(average)
                            
                            let halfCount = TimeArrayTemp.count / 2
                            // halfCount is automatically an Int
                            self.TimeArray.append(TimeArrayTemp[halfCount])
                            
                            self.pressureArrayTemp.removeAll()
                            self.TimeArrayTemp.removeAll()
                            self.timerCount += 1
                            print("C p count: \(self.pressureArray.count)")
                            print("C T count: \(self.TimeArray.count)")
                            print("Cpt count: \(self.pressureArrayTemp.count)")
                            print("CTt count: \(self.TimeArrayTemp.count)")
                        }
                    }

                    if !self.pressureTimerActive {
                        self.pressureTimerActive = true
                        self.timerCount = 0
                    }


                }
            } else {
                DispatchQueue.main.async {
                   
                    if self.timerCount == 0 {
                        self.pressureArray.removeAll()
                        self.TimeArray.removeAll()
                        self.pressureArrayTemp.removeAll()
                        self.TimeArrayTemp.removeAll()
                    }

                    self.pressureArray.removeAll()
                    self.TimeArray.removeAll()
                    self.pressureArrayTemp.removeAll()
                    self.TimeArrayTemp.removeAll()
                    self.pressureTimerActive = false
                    self.timerCount = 0
                    print("D p count: \(self.pressureArray.count)")
                    print("D T count: \(self.TimeArray.count)")
                    print("Dpt count: \(self.pressureArrayTemp.count)")
                    print("DTt count: \(self.TimeArrayTemp.count)")
                }
            }
        }
    }
    //MARK: 1 hz pressure
//    private func startMonitoringPressure_1hz() {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            guard bleManager.isConnected else { return }
//
//            if let pressure = Int(bleManager.pressure), pressure >= 30 {
//                DispatchQueue.main.async {
//                    if self.timerCount == 0 {
//                        self.pressureArray.removeAll()
//                        self.TimeArray.removeAll()
//                    }
//
//                    if self.pressureArray.count < 10 {
//                        self.pressureArray.append(pressure)
//                        self.TimeArray.append(bleManager.time)
//                    }
//
//                    if self.pressureArray.count >= 10 {
//                        // Append pressure data only once here
//                        taskManager.currentTask.taslitems[taskManager.currentMissionIndex].pressure_data.append(
//                            Pressure_one_time(P: self.pressureArray, T: self.TimeArray, iter: taskManager.current_iter)
//                        )
//
//                        self.pressureArray.removeAll()
//                        self.TimeArray.removeAll()
//                        self.pressureTimerActive = false
//                        self.timerCount = 0
//
//                        self.clickCount += 1
//                        taskManager.handleButtonClick()
//
//                        if self.clickCount % 10 == 0 {
//                            self.isremindshow.toggle()
//                        }
//
//                        if taskManager.currentTask.Completeness >= 100 {
//                            taskManager.isSummaryViewVisible = true
//                            self.showCompletionAlert = true
//                        }
//                    }
//
//                    if !self.pressureTimerActive {
//                        self.pressureTimerActive = true
//                        self.timerCount = 0
//                    }
//
//                    self.timerCount += 1
//                }
//            } else {
//                DispatchQueue.main.async {
//                    if self.timerCount == 0 {
//                        self.pressureArray.removeAll()
//                        self.TimeArray.removeAll()
//                    }
//
//                    self.pressureArray.removeAll()
//                    self.TimeArray.removeAll()
//                    self.pressureTimerActive = false
//                    self.timerCount = 0
//                }
//            }
//        }
//    }

    private func stopMonitoringPressure() {
        timer?.invalidate()
        timer = nil
        pressureTimerActive = false
    }
}

// Rotation Modifier
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}









// Circular Progress View Component
struct CircularProgressView: View {
    let total: Int
    let completed: Int
    let lineWidth: CGFloat
    let circleSize: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color

    var progress: CGFloat {
        guard total > 0 else { return 0 }
        return CGFloat(completed) / CGFloat(total)
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(foregroundColor, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
        .frame(width: circleSize, height: circleSize)
    }
}
