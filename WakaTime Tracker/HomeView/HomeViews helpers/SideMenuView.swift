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
                    // nav view with lottile view and xMark
                    NavView(isShowingMenuView: $isShowingMenuView)
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

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowingMenuView: .constant(true))
            .environmentObject(neumorphism)
    }
}
// 1- nav view
struct NavView: View {
    @Environment(\.openURL) var openURL
    @Binding var isShowingMenuView: Bool
    var body: some View {
        HStack {
            VStack {
                LottieAnimationView(fileName: "coding")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 100)
                Button(action: {
                    withAnimation{
                        openURL(URL(string: "https://www.linkedin.com/in/tariq-almazyad-5a628a138/")!)
                        isShowingMenuView.toggle()
                    }
                    
                }, label: {
                    Text("App is\nDesigned and developed by\n@Tariq Almazyad")
                        .font(.subheadline)
                        .foregroundColor(Color(#colorLiteral(red: 0.5490196078, green: 0.5490196078, blue: 0.5490196078, alpha: 1)))
                        .multilineTextAlignment(.center)
                })
            }.padding(.horizontal, 4)
            Spacer()
            
            NeumorphismButton(
                shapeType: .roundedRectangle(cornerRadius: 100),
                normalImage: Image(systemName: "xmark.circle"),
                selectedImage: Image(systemName: "xmark.circle"),
                width: 40,
                height: 40,
                imageWidth: 30,
                imageHeight: 30,
                handler: {
                    withAnimation{ isShowingMenuView.toggle() }
                }
            ).padding(.trailing, 34)
            .padding(.bottom, 34)
            
        }.padding(.top, 63)
    }
}

// 2- buttons cell
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
                    case .appVersion: return
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

// enum Model
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
