//
//  UserDetailsView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/19/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI
import MessageUI

struct UserDetailsView: View {
    let user: UserStats
    @State private var progress: Double = 0.0
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),]
    var body: some View{
        ScrollView(.vertical, showsIndicators: false) {
            neumorphism.color.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12){
                ProfileImageView(user: user)// <- end of ZStck
                
                UserInfoView(user: user)
                
                TotalHoursView(user: user)
                
                LazyVGrid(columns: columns, spacing: 80){
                    ForEach(user.running_total.languages, id:\.self) { language in
                        LanguageProgressView(user: user, language: language)
                            .padding(.top, 40)
                    }
                }
                
            }.padding(.vertical, 60) // <- end of VStack
            
        }
        .background(neumorphism.color)
        .ignoresSafeArea()
        
    }
    
}
struct UserDetailsView_Previews: PreviewProvider {
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



//                        Print("progress \(progress)")
//                        Print("progress 22    \(((user.running_total.languages.first?.total_seconds ?? 00) / 3600) / (user.running_total.total_seconds / 3600))")

//                            self.progress = ((user.running_total.languages.first?.total_seconds ?? 00) / 3600) / (user.running_total.total_seconds / 3600) * 100
//                Button(action: {
//
//                }, label: {
//                    Text("Button")
////                    Print("Total percentage is \( ( (user.running_total.languages.first?.total_seconds ?? 0.0) / 3600) / (user.running_total.total_seconds / 3600))")
////                    Print("Total percentage is \((user.running_total.languages.first?.total_seconds ?? 00) / 3600)")
//                }).padding()

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

struct LanguageProgressView: View {
    let user: UserStats
    let language: Languages
    @State var progress: Double = 0.0
    let randomColor = Color(red: .random(in: 0...1),
                            green: .random(in: 0...1),
                            blue: .random(in: 0...1))
    var body: some View {
        VStack {
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
                Timer.scheduledTimer(withTimeInterval: 0.002, repeats: true) { timer in
                    self.progress += 0.1234
                    if self.progress >= languageProgress(language.total_seconds)
                    {
                        self.progress = languageProgress(language.total_seconds)
                        timer.invalidate()
                    }
                }
            }
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
    
    private func languageProgress(_ totalSeconds: Double) -> Double{
        return ((totalSeconds) / 3600) / (user.running_total.total_seconds / 3600) * 100
    }
}

struct TotalHoursView: View {
    let user: UserStats
    var body: some View {
        VStack(spacing: 8){
            Text("Total hours coded over the last 7 days:")
                .font(.system(size: 12, weight: .semibold, design: .default))
                .foregroundColor(Color.gray)
            Text(user.running_total.human_readable_total)
                .font(.system(size: 16, weight: .bold, design: .default))
                .foregroundColor(Color(.lightGray))
            
        }
    }
}

struct UserInfoView: View {
    let user: UserStats
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        VStack(spacing: 8){
            Text("\(user.user.display_name),  rank#\(user.rank)")
                .font(.system(size: 20, weight: .bold, design: .default))
                .foregroundColor(Color(.white))
            Text(user.user.email ?? "no email provided")
                .font(.system(size: 14, weight: .semibold, design: .default))
                .foregroundColor(Color(.lightGray))
        }
    }
}
