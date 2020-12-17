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
    @Published var filteredLanguage: LanguageSelection = .All
    
    
    func languageFilter(forFilter filter: LanguageSelection) -> [UserStats]  {
        
        switch filter {
        case .All: return users
        case .Swift: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Swift"})}
        case .Python: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Python"})}
        case .Java: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Java"})}
        case .JavaScript: return users.filter{$0.running_total.languages.contains(where: {$0.name == "JavaScript"})}
        case .Kotlin: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Kotlin"})}
        case .TypeScript: return users.filter{$0.running_total.languages.contains(where: {$0.name == "TypeScript"})}
        case .Bash: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Bash"})}
        case .C: return users.filter{$0.running_total.languages.contains(where: {$0.name == "C"})}
        case .Cocoa: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Cocoa"})}
        case .CSS: return users.filter{$0.running_total.languages.contains(where: {$0.name == "CSS"})}
        case .PHP: return users.filter{$0.running_total.languages.contains(where: {$0.name == "PHP"})}
        case .Dart: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Dart"})}
        case .Ruby: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Ruby"})}
        case .SQL: return users.filter{$0.running_total.languages.contains(where: {$0.name == "SQL"})}
        case .Svelte: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Svelte"})}
        case .Lua: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Lua"})}
        case .GraphQL: return users.filter{$0.running_total.languages.contains(where: {$0.name == "GraphQL"})}
        case .Groovy: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Groovy"})}
        case .YAML: return users.filter{$0.running_total.languages.contains(where: {$0.name == "YAML"})}
        case .Vue: return users.filter{$0.running_total.languages.contains(where: {$0.name == "Vue"})}
        case .HTML: return users.filter{$0.running_total.languages.contains(where: {$0.name == "HTML"})}
        case .JSON: return users.filter{$0.running_total.languages.contains(where: {$0.name == "JSON"})}
        case .XML: return users.filter{$0.running_total.languages.contains(where: {$0.name == "XML"})}
        case .INI: return users.filter{$0.running_total.languages.contains(where: {$0.name == "INI"})}
        }
    }
    
    func getUsers(){
        isLoading = true
        NetworkManager.shared.downloadUsers { [weak self] result in
            guard let self = self else {return}
            
            // update UI on mainThread
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                self.objectWillChange.send()
                // check result
                switch result {
                case .success( let wakatimeData ):
                    self.wakatimeData = wakatimeData
                    self.users = wakatimeData.data
                    print(self.wakatimeData?.data)
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
