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
    let name : String
    let total_seconds : Double
}
struct User: Codable, Hashable {
    let id =  UUID().uuidString
    let full_name: String
    let display_name:  String
    let photo:  String
}




//let client_id = "K5ZeXSwIQONSWI5UhHBRTDnj"
//let secret = "sec_ekyJ1jDxXz5F2IveY4io03pQjpCOaV15PbTZ8uXfh40XGSEHkKcMADpcStJuRCJdDSa35adKNig4imFV"
//let authorizeUrl = "https://wakatime.com/oauth/authorize"
//let accessTokenUrl = "https://wakatime.com/oauth/token"
//let WAKATIME_API_AUTH_KEY = "Basic \((client_id + ":" + secret).data(using: .utf8)?.base64EncodedString() ?? "" )"



