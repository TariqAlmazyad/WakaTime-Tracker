//
//  WakaTimeNetwork.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI

class WakaTimeNetwork: ObservableObject {
    @Published var wakaTimeData : WakaTimeData?
    @Published var isLoading = true
    @Published var errorMessage = ""
    
    init() {
        guard let urlString = URL(string: "https://wakatime.com/api/v1/leaders") else {return}
        URLSession.shared.dataTask(with: urlString) { [weak self] (data, response, error) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                if let response = (response as? HTTPURLResponse)?.statusCode , response >= 400 {
                    self?.errorMessage = "Bad request \(response)"
                    self?.isLoading = false
                    return
                }
                guard let data = data else {return}
                do {
                    let users = try JSONDecoder().decode(WakaTimeData.self, from: data)
                    self?.wakaTimeData = users
                    self?.isLoading = false
                } catch (let error) {
                    print("failed to decode the data with \(error.localizedDescription)")
                    self?.isLoading = false
                }
            }
        }.resume()
    }
    
}
