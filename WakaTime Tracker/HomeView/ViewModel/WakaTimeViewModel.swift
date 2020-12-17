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
                    for language in self.users {
                        print(language.running_total.languages)
                    }
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
    
    func languageFilter(forFilter filter: LanguageSelection) -> [UserStats]  {
        switch filter {
        case .All: return users
        case .Swift: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Python: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Java: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Rust: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .JavaScript: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Kotlin: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .TypeScript: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Bash: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .C: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Cocoa: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .CSS: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .PHP: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Dart: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Ruby: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .SQL: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Svelte: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Lua: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .GraphQL: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Groovy: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .YAML: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .Vue: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .HTML: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .JSON: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .XML: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        case .INI: return users.filter{$0.running_total.languages.contains(where: {$0.name == filter.languageName})}
        }
    }
}
