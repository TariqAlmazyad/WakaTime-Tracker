//
//  UserDetailsView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/19/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI

struct UserDetailsView: View {
    let user: UserStats
    @State private var progress: Double = 0.0
    
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: false) {
            neumorphism.color.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12){
                
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
                }// <- end of ZStck
                
                Text(user.user.display_name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(Color(.white))
                VStack(spacing: 8){
                    Text("Total hours coded over the last 7 days:")
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .foregroundColor(Color.gray)
                    Text(user.running_total.human_readable_total)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(.lightGray))
                }// <- end of VStack
                
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
                        .foregroundColor(Color.purple)
                        .frame(width: 100, height: 100)
                    Circle()
                        .trim(from: 0.0, to: CGFloat(self.progress / 100))
                        .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round,
                                                   lineJoin: .round))
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.purple)
                        .animation(Animation.easeIn(duration: 2))
                    Text("% \(String(format: "%.2f", self.progress))")
                }
                
                Button(action: {
                    Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { timer in
                        self.progress += 0.1234
                        if self.progress >= ((user.running_total.languages.first?.total_seconds ?? 00) / 3600) {
                            timer.invalidate()
                        }
                    }
                }, label: {
                    Text("Button")
                }).padding()
                
            }.padding(.vertical, 80) // <- end of VStack
            
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
                                                photo: "")))
            .environmentObject(neumorphism)
            
            //        ContentView()
            .preferredColorScheme(.dark)
        //            .environmentObject(neumorphism)
    }
}
