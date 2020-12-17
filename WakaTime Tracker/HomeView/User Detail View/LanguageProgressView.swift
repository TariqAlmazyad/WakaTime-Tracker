//
//  LanguageProgressView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/8/20.
//

import SwiftUI
import NeumorphismUI

struct LanguageProgressView: View {
    let user: UserStats
    let language: Languages
    @State var progress: Double = 0.0
    var body: some View {
        VStack {
            circularProgressView(user: user, progress: $progress, language: language)
            VStack(spacing: 12) {
                HStack(spacing: 0) {
                    Text("Hours Coded in: ")
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .foregroundColor(Color.gray)
                    Text(language.name ?? "")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
                Text("\(Double(language.total_seconds ).asString(style: .full))")
                Print("\(Double(language.total_seconds ).asString(style: .full))")
            }.padding(.top)
        }
    }
}

struct LanguageProgressView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: .init(rank: 1,
                                    running_total: .init(daily_average: 98,
                                                         human_readable_daily_average: "",
                                                         human_readable_total: "",
                                                         total_seconds: 65,
                                                         languages: [.init(name: "",
                                                                           total_seconds: 32)]),
                                    user: .init(display_name: "Tariq Almazyad",
                                                photo: "", email: nil, location: "")))
            .environmentObject(neumorphism)
            .preferredColorScheme(.dark)
        
        
    }
}

struct circularProgressView: View {
    let randomColor = Color(red: .random(in: 0...1),
                            green: .random(in: 0...1),
                            blue: .random(in: 0...1))
    let user: UserStats
    @Binding var progress: Double
    let language: Languages
    var body: some View {
        ZStack {
            NeumorphismButton(
                shapeType: .roundedRectangle(cornerRadius: 100),
                normalImage: Image(systemName: "checkmark.circle"),
                selectedImage: Image(systemName: ""),
                width: 120,
                height: 120,
                imageWidth: 0,
                imageHeight: 0
            )
            
            Circle()
                .stroke(lineWidth: 5)
                .opacity(0.2)
                .foregroundColor(randomColor.opacity(0.8))
                .frame(width: 100, height: 100)
            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress / 100))
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round,
                                           lineJoin: .round))
                .frame(width: 100, height: 100)
                .foregroundColor(randomColor)
                .animation(Animation.easeIn(duration: 2))
                .shadow(color: randomColor, radius: 10, x: 0.0, y: 0.0)
            
            VStack(alignment: .center) {
                if let imageName = language.name {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                } else {
                    Image(systemName: "questionmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
                
                Text("% \(String(format: "%.2f", self.progress))")
                    .padding(.top, 4)
            }.padding(.bottom)
            
        }
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 0.0002, repeats: true) { timer in
                self.progress += 1.1234
                if self.progress >= languageProgress(language.total_seconds)
                {
                    self.progress = languageProgress(language.total_seconds)
                    timer.invalidate()
                }
            }
        }
    }
    
    private func languageProgress(_ totalSeconds: Double) -> Double{
        return ((totalSeconds) / 3600) / (user.running_total.total_seconds / 3600) * 100
    }
    
}
