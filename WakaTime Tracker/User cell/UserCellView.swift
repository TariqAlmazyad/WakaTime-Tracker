//
//  UserCellView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI

struct UserCellView: View {
    let user: UserStats
    
    var body: some View {
        VStack {
            // rank
            HStack{
                Text("Rank #\(user.rank)")
                    .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                Spacer()
            }.padding(.horizontal)
            // profileImage
            UserImageView(user: user)
            // username
            Text(user.user.display_name)
                .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                .frame(width: UIScreen.screenWidth / 2.4)
                .padding(.top)
                // total 7 days capsule
            Total_7_DaysView(user: user)
            Text("Average Daily Time")
                .font(.system(size: 14))
                .foregroundColor(Color.white.opacity(0.5))
                .padding(.top, 2)
            Text("\(Double(user.running_total.daily_average).asString(style: .full))")
                .foregroundColor(Color(#colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)))
                .padding(.top, 1.5)
            
            // top used languages
            ZStack {
                Capsule(style: .circular)
                    .fill(neumorphism.color)
                    .neumorphismConcave(shapeType: .capsule, color: nil)
                    .frame(width: UIScreen.screenWidth / 2.6, height: 44)
                Text("Top used languages")
                    .font(.system(size: 14))
                    .foregroundColor(Color.white.opacity(0.5))
            }
            
            TopUsedLanguagesView(user: user)
            
        }
    }
    
  
}
struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVGridView()
            .environmentObject(neumorphism)
    }
}
