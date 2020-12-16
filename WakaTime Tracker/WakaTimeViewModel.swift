//
//  WakaTimeViewModel.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/16/20.
//

import SwiftUI

final class WakaTimeViewModel: ObservableObject {
    @Published var wakatimeData: WakaTimeData?
    @Published var users: [UserStats] = []
    @Published var selectedUser: UserStats?
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    @Published var isShowingUserDetail: Bool = false
    
    
    func getUsers(){
        isLoading = true
        NetworkManager.shared.downloadUsers { [weak self] result in
            guard let self = self else {return}
            
            // update UI on mainThread
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                // check result
                switch result {
                case .success( let wakatimeData ):
                    self.wakatimeData = wakatimeData
                    self.users = wakatimeData.data

                    
                    // if failure? display the proper prompt.
                case .failure( let error):
                    switch error {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                        
                    case .connectionError:
                        self.alertItem = AlertContext.connectionError
                        
                    case .invalidJSON:
                        self.alertItem = AlertContext.invalidJSON
                    }
                }
                
                self.isLoading = false
            }
        }
    }
}
