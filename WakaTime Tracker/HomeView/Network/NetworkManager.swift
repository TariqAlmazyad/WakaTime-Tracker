//
//  NetworkManager.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/16/20.
//

import Foundation
import SwiftUI
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case connectionError
    case invalidJSON
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {

    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      message: Text("URL is not valid for request.\nPlease report this bug to the developer."),
                                      dismissButton: .default(Text("Ok")))
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                           message: Text("Invalid response from the server. Please try again later or contact the developer."),
                                           dismissButton: .default(Text("Ok")))
    static let connectionError = AlertItem(title: Text("Connection Error"),
                                           message: Text("Please check your connection and try again.\nIf this issue persists, please report it to the developer"),
                                           dismissButton: .default(Text("Ok")))
    static let invalidJSON = AlertItem(title: Text("Server Error"),
                                       message: Text("The data received from the server was invalid. Please contact support."),
                                       dismissButton: .default(Text("Ok")))
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrlString = "https://wakatime.com/api/v1/leaders"
    
    private init () {}
    
    private var isLoading: Bool = true
    
    func downloadUsers(completion: @escaping(Result<WakaTimeData, NetworkError>) -> Void){
        // 1 check for url and safely unwrapp
        guard let url = URL(string: baseUrlString) else {
            completion(.failure(.invalidURL))
            return
        }
        // 2 start URLSession to get data from WakaTime.com
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else {return}
            DispatchQueue.main.async { [weak self] in
                
                // 3 check for response
                if let response = (response as? HTTPURLResponse)?.statusCode, response >= 400 {
                    completion(.failure(.invalidResponse))
                    return
                }
                // 4 check for data
                guard let data = data else {
                    completion(.failure(.invalidJSON))
                    return
                }
                
                // 5 decode data and escape with result
                do {
                    let decodedData = try JSONDecoder().decode(WakaTimeData.self, from: data)
                    print("Total pages is \(decodedData.page)")
                    completion(.success(decodedData))
                    
                } catch (let error){
                    completion(.failure(.invalidJSON))
                    print("Failed to decode JSON due to unMatched struct \(error.localizedDescription)")
                }
            }
        }.resume()
        
    }
    
}
