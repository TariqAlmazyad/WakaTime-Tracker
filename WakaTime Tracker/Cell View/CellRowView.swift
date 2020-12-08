//
//  CellRowView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI
import SDWebImageSwiftUI
import NeumorphismUI
import SafariServices


struct CellRowView: View {
    let user: UserStats
    @EnvironmentObject var neumorphism: NeumorphismManager
    var body: some View {
        
        VStack {
            RankAndProfileView(user: user)
            
            Text(user.user.display_name)
                .padding(.top)
            
            Pass_7_DaysTimeView(user: user)
                .padding(.top, 12)
            
            AverageDailyTimeView(user: user)
                .padding(.top, 8)
            
            TopLanguagesView(user: user)
                .padding(.top, 16)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct CellRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(neumorphism)
    }
}



struct AverageDailyTimeView: View {
    let user: UserStats
    var body: some View {
        VStack(spacing: 4){
            Text("Average Daily Time:")
                .foregroundColor(.gray)
                .font(.system(size: 12, weight: .light))
            Text("\(Double(user.running_total.daily_average).asString(style: .full))")
                .font(.system(size: 14, weight: .regular))
        }
    }
}

