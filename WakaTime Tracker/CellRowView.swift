//
//  CellRowView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI
import SDWebImageSwiftUI
import NeumorphismUI

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

struct CellRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(neumorphism)
    }
}

struct RankAndProfileView: View {
    let user: UserStats
    var body: some View{
        HStack {
            Text("Rank #\(user.rank)")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.white)
            Spacer()
        }.padding(.horizontal)
        ZStack{
            Circle()
                .fill(neumorphism.color)
                .frame(width: 100, height: 100)
                .neumorphismShadow()
            WebImage(url: URL(string: user.user.photo))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(40)
                .clipped()
                .neumorphismShadow()
        }
    }
}

struct Pass_7_DaysTimeView: View {
    let user: UserStats
    var body: some View {
        ZStack {
            Capsule(style: .circular)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .capsule, color: nil)
                .frame(width: 140, height: 60)
            VStack {
                Text("Total pass 7 days:")
                    .foregroundColor(.gray)
                    .font(.system(size: 12, weight: .light))
                Text(user.running_total.human_readable_total)
                    .font(.system(size: 14, weight: .regular))
            }
        }
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

struct TopLanguagesView: View {
    let user: UserStats
    var body: some View{
        ZStack {
            Capsule(style: .circular)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .capsule, color: nil)
                .frame(width: 160, height: 40)
            Text("Top use languages")
                .foregroundColor(.gray)
                .font(.system(size: 14, weight: .light))
        }.padding(.top, 4)
        
        HStack {
            ForEach(user.running_total.languages.prefix(3), id: \.self) { language in
                NeumorphismButton(
                    shapeType: .roundedRectangle(cornerRadius: 20),
                    normalImage: Image(language.name),
                    selectedImage: Image(language.name),
                    width: 40,
                    height: 40,
                    imageWidth: 30,
                    imageHeight: 30,
                    
                    handler: {
                        print("did select")
                    }
                )
            }
        }
    }
}
