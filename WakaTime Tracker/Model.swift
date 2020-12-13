//
//  Model.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import Foundation

struct WakaTimeData: Codable, Hashable {
    let data: [UserStats]
    let range: Range
}

struct CurrentUser: Codable, Hashable {
    let full_name:  String
    let human_readable_website: String
    let id:  String
    let is_hireable:  Bool
    let location:  String
    let photo:  String
    let username:  String
    let website: String
}

struct Range: Codable, Hashable {
    let end_date : String
    let end_text : String
    let name : String
    let start_date : String
    let start_text : String
    let text : String
}

struct UserStats: Codable, Hashable {
    let rank: Int
    let running_total: RunningTime
    let user: User
}

struct RunningTime: Codable, Hashable {
    let daily_average : Int
    let human_readable_daily_average : String
    let human_readable_total : String
    let total_seconds : Double
    let languages : [Languages]
    
}

struct Languages: Codable, Hashable {
    let name : String?
    let total_seconds : Double
}


struct User: Codable, Hashable {
    var id =  UUID().uuidString
//    let full_name: String 
    let display_name:  String
    let photo:  String
    let email: String?
    let location: String
}




//let client_id = "K5ZeXSwIQONSWI5UhHBRTDnj"
//let secret = "sec_ekyJ1jDxXz5F2IveY4io03pQjpCOaV15PbTZ8uXfh40XGSEHkKcMADpcStJuRCJdDSa35adKNig4imFV"
//let authorizeUrl = "https://wakatime.com/oauth/authorize"
//let accessTokenUrl = "https://wakatime.com/oauth/token"
//let WAKATIME_API_AUTH_KEY = "Basic \((client_id + ":" + secret).data(using: .utf8)?.base64EncodedString() ?? "" )"



enum LanguageSelection: String, CaseIterable {
    case Bash
    case C
    case Cocoa
    case CSS
    case PHP
    case Dart
    case Ruby
    case SQL
    case Svelte
    case Lua
    case GraphQL
    case Python
    case Groovy
    case Swift
    case YAML
    case Vue
    case HTML
    case JSON
    case XML
    case TypeScript
    case Kotlin
    case INI
    case Java
    case JavaScript
    
    var languageName: String {
        switch self {
        case .Bash: return "Bash"
        case .C: return "Bash"
        case .Cocoa: return "C#"
        case .CSS: return "Cocoa"
        case .PHP: return "CSS"
        case .Dart: return "PHP"
        case .Ruby: return "Dart"
        case .SQL: return "SQL"
        case .Svelte: return "Svelte"
        case .Lua: return "Lua"
        case .GraphQL: return "GraphQL"
        case .Python: return "Python"
        case .Groovy: return "Groovy"
        case .Swift: return "Swift"
        case .YAML: return "YAML"
        case .Vue: return "Vue.js"
        case .HTML: return "HTML"
        case .JSON: return "JSON"
        case .XML: return "XML"
        case .TypeScript: return "TypeScript"
        case .Kotlin: return "Kotlin"
        case .INI: return "INI"
        case .Java: return "Java"
        case .JavaScript: return "JavaScript"
        }
    }
}
