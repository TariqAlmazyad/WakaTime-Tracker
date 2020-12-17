//
//  SideMenuView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI
import MessageUI

struct SideMenuView: View {
    
    @Binding var isShowingMenuView: Bool
    var body: some View {
        ZStack{
            neumorphism.color.ignoresSafeArea()
            VStack{
                VStack {
                    HStack {
                        VStack {
                            LottieAnimationView(fileName: "coding")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 100)
                            Text("Designed by\nTariq Almazyad")
                                .font(.subheadline)
                                .foregroundColor(Color(#colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1)))
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                        Button(action: {
                            withAnimation{ isShowingMenuView.toggle() }
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color(#colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)))
                                .font(.system(size: 24))
                                .padding(.horizontal, 34)
                                .padding(.bottom, 64)
                        })
                    }.padding(.top, 63)
                    
                    
                    ScrollView {
                        ForEach(SideMenuViewModel.allCases, id:\.self) { optionViewModel in
                            SideMenuCell(optionViewModel: optionViewModel)
                                .padding()
                                .padding(.bottom, 23)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            
        }.ignoresSafeArea()
        .offset(x: isShowingMenuView ? 0 : 300, y: isShowingMenuView ? 0 : 44)
        .scaleEffect(isShowingMenuView ? 1 : 0)
    }
}


struct SideMenuCell: View {
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @Environment(\.openURL) var openURL
    
    let optionViewModel: SideMenuViewModel
    var body: some View {
        HStack{
            VStack{
                Button(action: {
                    switch optionViewModel {
                    case .wakaTimeWebsite:
                        openURL(URL(string: "https://wakatime.com/")!)
                    case .appVersion:
                        Print("appVersion")
                    case .reportBug:
                        isShowingMailView.toggle()
                    }
                }, label: {
                    HStack{
                        Image(systemName: optionViewModel.imageName)
                            .font(.title3)
                        Text(optionViewModel.title)
                    }.foregroundColor( optionViewModel == .reportBug ? Color(#colorLiteral(red: 0.9874717593, green: 0.4808713198, blue: 0.4829602242, alpha: 1)) : Color(#colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)))
                })
            }
            Spacer()
            
        }.sheet(isPresented: $isShowingMailView) {
            MailView(result: $result, emailAdress: .constant("Tariq.Almazyad@gmail.com"),
                     fullName: .constant("Tariq Almazyad"))
        }
        
    }
}


struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowingMenuView: .constant(true))
    }
}

import Foundation
enum SideMenuViewModel: Int, CaseIterable {
    case wakaTimeWebsite
    case appVersion
    case reportBug
    
    var imageName: String{
        switch self {
        case .reportBug: return "ladybug"
        case .appVersion: return "apps.iphone"
        case .wakaTimeWebsite: return "globe"
        }
    }
    
    var title: String{
        switch self {
        case .reportBug: return "Report a bug"
        case .appVersion: return "App version: \(Bundle.mainAppVersion ?? "" )"
        case .wakaTimeWebsite: return "Visit WakaTime.com"
        }
    }
    
}
