//
//  ProfileImageView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/8/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileImageView: View {
    let user: UserStats
    var body: some View {
        ZStack{
            Capsule(style: .circular)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .capsule, color: nil)
                .frame(width: 100, height: 100)
            
            WebImage(url: URL(string: user.user.photo), isAnimating: Binding.constant(true))
                .resizable()
                .scaledToFit()
                .frame(width: 76, height: 76)
                .clipShape(Circle())
        }
    }
}
struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: .init(rank: 1,
                                    running_total: .init(daily_average: 98,
                                                         human_readable_daily_average: "",
                                                         human_readable_total: "",
                                                         total_seconds: 65,
                                                         languages: [.init(name: "",
                                                                           total_seconds: 32)]),
                                    user: .init(full_name: "Tariq Almazyad",
                                                display_name: "Tariq Almazyad",
                                                photo: "", email: nil)))
            .environmentObject(neumorphism)
            .preferredColorScheme(.dark)
        
        
    }
}
