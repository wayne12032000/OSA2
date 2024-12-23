//
//  SettingView.swift
//  OSA2
//
//  Created by 張世維 on 2023/10/21.
//

import SwiftUI

import UniformTypeIdentifiers  // Add this import


struct SettingView: View {
    // Existing state properties
    @EnvironmentObject var dataManager: DataManager
    @State private var document: ExportableDocument?
//    @State private var document: ExportableDocument?
        @State private var showShareSheet = false
        @State private var fileURL: URL?
    @State private var historyData: Data?
    var body: some View {
       

        VStack { //a
            // Your existing ZStack and Image code
            ZStack{
                Image("setting_view")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
//                Image("my_circle_1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 150)
//                    .offset(y:130)
//                    .frame(maxWidth: .infinity,alignment:.center)
//                    .padding(.horizontal)
                //                        .clipShape(Circle())
            }
            HStack {
                Image("S__24862787")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25) // Ensure this height matches the size of your text

                Text(": \(dataManager.credit)")
                    // .padding(.top) // If you need padding on top, you can uncomment this line
            }
            .padding(.horizontal) // Add horizontal padding if needed
            .frame(maxWidth: .infinity) // This will center the HStack in the parent view


            VStack(spacing: 0.0){
                
                HStack{
                    NavigationLink(destination: NewHistoryView()) {
                        VStack{
                            Image(systemName: "calendar")
                                .padding(.vertical,4)
                                .padding(.horizontal,12)
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                            Text("歷史數據").foregroundColor(.black)
                        }
                        
                    }.frame(maxWidth: .infinity,alignment: .center)
                        .padding(.horizontal)
                    NavigationLink(destination: IconSetView()) {
                        VStack{
                            Image(systemName: "cart")
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                            Text("商店").foregroundColor(.black)
                        }
                       
                    }.frame(maxWidth: .infinity,alignment: .center)
                        .padding()
                    NavigationLink(destination: SettingDetailView()) {
                        VStack{
                            Image(systemName: "gear")
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                            Text("設定").foregroundColor(.black)
                        }
                       
                    }.frame(maxWidth: .infinity,alignment: .center)
                        .padding()
                    //                        Button("Export JSON File") {
                    //                            exportFile()
                    //                                }
                    
                    
                }
                // 假設你已經有了一些要分享的數據
//                Button("Export history Data") {
//                    // Convert your DayHistory data to JSON Data.
//                    let encoder = JSONEncoder()
//                    if let jsonData = try? encoder.encode(dataManager.DayHistory) {
//                        self.historyData = jsonData
//                    } else {
//                        print("Failed to encode DayHistory")
//                    }
//                }
//                
//                
//                
//                
//                // Use ShareLink only if documentData is not nil
//                if let data = historyData {
//                    ShareLink(item: data, preview: SharePreview("Your data", image: Image(systemName: "doc.text")))
//                        .buttonStyle(.bordered)
//                }
//                Button("Logout") {
//                    // Convert your DayHistory data to JSON Data.
//                    dataManager.isLogin = false
//                }
//                
//                Text(dataManager.username).font(.largeTitle)
                
                
            }.padding(.horizontal)
                .frame(alignment: .bottom)
               
                    
          

           
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .cornerRadius(12)
        .edgesIgnoringSafeArea(.top)
        
    }
    func getDocumentsDirectory() -> URL {
            // 在這裡實現獲取Documents目錄的方法
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
            return paths[0]
        }
    func exportData() {
            guard let jsonData = dataManager.exportDayHistory() else { return }
            let fileName = "DayHistory.json"
            let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

            do {
                try jsonData.write(to: path, atomically: true, encoding: .utf8)
                self.fileURL = path
                self.showShareSheet = true
            } catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    
    private func saveAndExport(exportString: String) {
        let fileName = "DayHistoryExport.json"
        let path = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        do {
            try exportString.write(to: path, atomically: true, encoding: .utf8)
            self.fileURL = path
            self.showShareSheet = true
        } catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }



}

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update required
    }
}
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update required
    }
}
struct ExportableDocument: FileDocument {
    static var readableContentTypes = [UTType.json] // The file type(s) your document supports.
    
    var text: String
    
    init(text: String = "") {
        self.text = text
    }
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents,
           let string = String(data: data, encoding: .utf8) {
            text = string
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return FileWrapper(regularFileWithContents: data)
    }
}
struct Document: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }
    let fileURL: URL?

    init(fileURL: URL?) {
        self.fileURL = fileURL
    }

    init(configuration: ReadConfiguration) throws {
        fatalError("Not implemented")
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        guard let fileURL = fileURL else {
            throw CocoaError(.fileReadNoSuchFile)
        }

        do {
            let data = try Data(contentsOf: fileURL)
            return FileWrapper(regularFileWithContents: data)
        } catch {
            throw error
        }
    }
}
struct Setting2View: View {
    // MARK: For Storing Currently Active App Icon
    @State private var isExporting = false
    @State private var isDocumentPickerPresented: Bool = false
    
    @EnvironmentObject var dataManager:DataManager
    var body: some View {
        
        VStack{//a
            ZStack{
                Image("chair_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
//                Image("my_circle_1")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(height: 150)
//                    .offset(y:130)
//                    .frame(maxWidth: .infinity,alignment:.center)
//                    .padding(.horizontal)
                //                        .clipShape(Circle())
            }
            HStack {
                Image("S__24862787")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25) // Ensure this height matches the size of your text

                Text(": \(dataManager.credit)")
                    // .padding(.top) // If you need padding on top, you can uncomment this line
            }
            .padding(.horizontal) // Add horizontal padding if needed
            .frame(maxWidth: .infinity) // This will center the HStack in the parent view


            
            Spacer()
            
            VStack(spacing: 0.0){
                
                HStack{
                    NavigationLink(destination: HistoryView()) {
                        VStack{
                            Image(systemName: "calendar")
                                .padding(.vertical,4)
                                .padding(.horizontal,12)
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                            Text("歷史數據").foregroundColor(.black)
                        }
                        
                    }.frame(maxWidth: .infinity,alignment: .center)
                        .padding(.horizontal)
                    NavigationLink(destination: IconSetView()) {
                        VStack{
                            Image(systemName: "cart")
                                .padding(.vertical,4)
                                .padding(.horizontal)
                                .font(.system(size: 50))
                                .foregroundColor(.black)
                            Text("商店").foregroundColor(.black)
                        }
                       
                    }.frame(maxWidth: .infinity,alignment: .center)
                        .padding()
                    //                        Button("Export JSON File") {
                    //                            exportFile()
                    //                                }
                    
                    
                }
                
                
                
            }.padding(.horizontal)
                .frame(alignment: .bottom)
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
        .cornerRadius(12)
        .edgesIgnoringSafeArea(.top)
        
    }
}
//    private func exportFile() {
//        guard let exportableData = try? JSONEncoder().encode(dataManager.DayHistory) else {
//                print("Failed to encode data.")
//                return
//            }
//
//            let temporaryDirectoryURL = FileManager.default.temporaryDirectory
//            let exportableFileURL = temporaryDirectoryURL.appendingPathComponent("exported_data.json")
//
//            do {
//                try exportableData.write(to: exportableFileURL)
//            } catch {
//                print("Failed to write data to file: \(error)")
//                return
//            }
//
//            let documentInteractionController = UIDocumentInteractionController(url: exportableFileURL)
//            documentInteractionController.delegate = self
//            documentInteractionController.presentOptionsMenu(from: CGRect.zero, in: UIApplication.shared.windows.first!, animated: true)
//        }
//    }
    


//extension SettingView: UIDocumentInteractionControllerDelegate {
//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//        return UIApplication.shared.windows.first!.rootViewController!
//    }
//}
#Preview {
    SettingView()
}


//
//NavigationStack{
//    Picker(selection: $activeAppIcon) {
//        let customIcons: [String] = ["AppIcon", "AppIcon 1", "AppIcon 2", "AppIcon 3"]
//        ForEach (customIcons, id: \.self){icon in
//            Text (icon) .tag (icon)
//        }
//    }label: {
//        
//    }
//}.onChange(of: activeAppIcon) { _ in
//    // MARK: Setting Alternative Icon
//    UIApplication.shared.setAlternateIconName(activeAppIcon)
//}
