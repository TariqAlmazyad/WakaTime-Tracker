//
//  WakaTimeRefView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/21/20.
//

import SwiftUI

struct WakaTimeRefView: View {
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView{
            ZStack {
                neumorphism.color.edgesIgnoringSafeArea(.all)
                VStack{
                    
                    JSONAnimationView()
                    
                    InfoView()
                    
                    Button(action: {
                        openURL(URL(string: "https://wakatime.com/")!)
                    }, label: {
                        HStack(spacing: 12){
                            Text("Visit WakaTime")
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .frame(width: 200, height: 50)
                        .background(Color(#colorLiteral(red: 0.3206369877, green: 0.4912649989, blue: 0.6437543035, alpha: 1)))
                        .cornerRadius(25)
                        .foregroundColor(.white)
                    }).padding(.top)
                    
                    
                }.padding(.vertical, 50)
            }
        }
        .background(neumorphism.color)
        .ignoresSafeArea()
    }
}

struct WakaTimeRefView_Previews: PreviewProvider {
    static var previews: some View {
        WakaTimeRefView()
            .environmentObject(neumorphism)
    }
}

struct InfoView: View {
    var body: some View {
        VStack(spacing: 6){
            Text("WakaTime is committed to making time tracking fully automatic for every programmer.")
                .frame(width: 300, height: 140)
                .font(.system(size: 24, weight: .bold, design: .default))
                .lineLimit(nil)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top, 20)
            Text("By creating open source plugins for IDEs and text editors, WakaTime gives powerful insights about how you code")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .lineLimit(nil)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct JSONAnimationView: View {
    var body: some View {
        ZStack {
            LottieAnimationView()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 300)
                .foregroundColor(.white)
            HStack {
                Spacer()
                    .frame(width: 120)
                Image("wakaTime")
                    .resizable()
                    .rotation3DEffect(
                        Angle(degrees: -40),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 20,
                        perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
                    )
                    .frame(width: 40, height: 40)
            }.padding(.top, -115)
            
            
        }.frame(width: 180, height: 300)
        .padding(.top, 120)
    }
}
