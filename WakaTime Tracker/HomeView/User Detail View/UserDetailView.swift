//
//  UserDetailView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI
struct UserDetailView: View {
    
    let user: UserStats
    @Binding var isShowingUserDetail: Bool
    
    var body: some View {
        ZStack {
            neumorphism.color.ignoresSafeArea()
            ScrollView {
                HStack{
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24))
                    })
                }
                Text("Hello, World!")
                
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: user, isShowingUserDetail: .constant(true))
    }
}

let user = UserStats(rank: 0,
                     running_total: .init(daily_average: 0,
                                          human_readable_daily_average: "",
                                          human_readable_total: "",
                                          total_seconds: 0.0,
                                          languages: [.init(name: "", total_seconds: 0.0)]),
                     user: .init(display_name: "", photo: "", email: "", location: ""))
