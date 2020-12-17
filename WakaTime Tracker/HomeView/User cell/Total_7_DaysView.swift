//
//  Total_7_DaysView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI

struct Total_7_DaysView: View {
    let user: UserStats
    var body: some View {
        ZStack(alignment: .top){
            Capsule(style: .circular)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .capsule, color: nil)
                .frame(width: 180, height: 64)
            VStack {
                Text("Total pass 7 days:")
                    .font(.system(size: 14))
                    .foregroundColor(Color.white.opacity(0.5))
                Text(user.running_total.human_readable_total)
                    .foregroundColor(Color(#colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)))
            }.padding(.top, 12)
        }
    }
}

struct Total_7_DaysView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVGridView()
            .environmentObject(neumorphism)
    }
}
