//
//  LoginRegisterView.swift
//  OSA2
//
//  Created by 張世維 on 2024/3/23.
//


//2024/03/22
//real api  and modify
//after login success call dataManager.download
//after register success call dataManager.download, but server side shoould check create a right default data
//above calling write after login success
//
//what to do next?
//give real api to test login 



import SwiftUI

struct LoginRegisterView: View {
    @EnvironmentObject var dataManager:DataManager
    
    @State private var isLogin = true // Toggle between login and registration
    @State private var username = ""
    @State private var password = ""
    @State private var additionalInfoForRegistration = "" // Example for registration specific data

    @State private var EMessage = "waiting..."
    var body: some View {
        VStack {
            Picker("Mode", selection: $isLogin) {
                Text("Login").tag(true)
                Text("Register").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)

            TextField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)

            if !isLogin {
                // Additional fields for registration
                TextField("Additional Info", text: $additionalInfoForRegistration)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            Button(action: {
                if isLogin {
                    login(username: username, password: password)
                } else {
                    register(username: username, password: password, additionalInfo: additionalInfoForRegistration)
                }
                
            }) {
                Text(isLogin ? "Login" : "Register")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            
            Text(EMessage)
            
        }
    }
    
    
    
    
    
    func apiCall(url: URL, method: String, body: Data, completion: @escaping (Bool, String?, String?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(false, nil, error?.localizedDescription ?? "Unknown error")
                }
                return
            }
            
            if let httpRes = response as? HTTPURLResponse, httpRes.statusCode == 200 || httpRes.statusCode == 201 {
                // First, attempt to decode the data as JSON
                let decoder = JSONDecoder()
                if let jsonResponse = try? decoder.decode([String: String].self, from: data),
                   let token = jsonResponse["token"] {
                    DispatchQueue.main.async {
                        completion(true, token, nil)
                    }
                } else {
                    // If JSON decoding fails, treat the response as a raw string (token)
                    if let tokenString = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) {
                        DispatchQueue.main.async {
                            completion(true, tokenString, nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(false, nil, "Failed to decode response")
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(false, nil, "Server returned status code \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                }
            }
        }.resume()
    }

    func login(username: String, password: String) {
        guard let url = URL(string: "http://140.116.245.33:8080/login") else { return }
        let loginInfo = ["username": username, "password": password]
        
        guard let loginData = try? JSONEncoder().encode(loginInfo) else { return }
        
        apiCall(url: url, method: "POST", body: loginData) { success, token, errorMessage in
            if success, let token = token {
                print("Login Successful, Token: \(token)")
                EMessage = "Login Successful, Token: \(token)"
                dataManager.isLogin = true
                dataManager.username = username
                
                dataManager.downloadData(withToken: token)
                
                
                // Here, save the token for future use, e.g., in Keychain
            } else {
                print("Login Failed: \(errorMessage ?? "")")
                EMessage = "Login Failed: \(errorMessage ?? "")"
                dataManager.isLogin = false
            }
        }
    }

    func register(username: String, password: String, additionalInfo: String) {
        guard let url = URL(string: "http://140.116.245.33:8080/register") else { return }
        let registrationInfo = ["username": username, "password": password]
        
        guard let registrationData = try? JSONEncoder().encode(registrationInfo) else { return }
        
        apiCall(url: url, method: "POST", body: registrationData) { success, token, errorMessage in
            if success, let token = token {
                print("Registration Successful, Token: \(token)")
                EMessage = "Registration Successful, Token: \(token)"
                dataManager.isLogin = true
                dataManager.username = username
                
                //enable here to use server mode
                //dataManager.uploadData(withToken: token)
                
            } else {
                print("Registration Failed: \(errorMessage ?? "")")
                EMessage = "Registration Failed: \(errorMessage ?? "")"
                dataManager.isLogin = false
            }
        }
    }
    
    
    
    
    
}









#Preview {
    LoginRegisterView()
}
