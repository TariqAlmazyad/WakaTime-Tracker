//
//  WakaTimeNetwork.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI

enum WakaTimeError: Error {
    case invalidURL
    case invalidData
    case unableToComplete
    case invalidResponse
}

class WakaTimeNetwork: ObservableObject {
    @Published var wakaTimeData : WakaTimeData?
    @Published var isLoading = true
    @Published var errorMessage = ""
    @Published var progress: Double = 0.0
    @Published var dataTask: URLSessionTask?
    @Published var observation: NSKeyValueObservation?
    @Published var items: [Int] = []
    //3
    static private var itemsPerPage = 25
    var start = WakaTimeNetwork.itemsPerPage
    var stop = -1
    let maxData = 250
    
    private func incrementPaginationIndices() {
        start += WakaTimeNetwork.itemsPerPage
        stop += WakaTimeNetwork.itemsPerPage
        
        stop = min(maxData, stop)
    }
    
    init() {
        guard let urlString = URL(string: "https://wakatime.com/api/v1/leaders") else {return}
        dataTask = URLSession.shared.dataTask(with: urlString) { [weak self] (data, response, error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                guard let self = self else {return}
                
                self.observation?.invalidate()
                if let response = (response as? HTTPURLResponse)?.statusCode , response >= 400 {
                    self.errorMessage = "Bad request \(response)"
                    self.isLoading = false
                    return
                }
                guard let data = data else {return}
                do {
                    let users = try JSONDecoder().decode(WakaTimeData.self, from: data)
                    let newData = Array(arrayLiteral: users.data.start)
                    
                    self.isLoading = false
                } catch (let error) {
                    print("failed to decode the data with \(error.localizedDescription)")
                }
            }
        }
        observation = dataTask?.progress.observe(\.fractionCompleted, changeHandler: { (progress, _) in
            DispatchQueue.main.async {
                self.progress = progress.fractionCompleted
            }
        })
        
        dataTask?.resume()
        
    }
    
}

