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
                .scaledToFit()
                .background(Color(#colorLiteral(red: 0.1727925241, green: 0.1605206132, blue: 0.1728563607, alpha: 1)))
                .frame(width: 80, height: 80)
                .overlay(
                    Circle().stroke(Color(#colorLiteral(red: 0.1727925241, green: 0.1605206132, blue: 0.1728563607, alpha: 1)), lineWidth: 8)
                )
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
    @Environment(\.openURL) var openURL
    
    
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
        
        HStack(spacing: 0) {
            ForEach(user.running_total.languages.prefix(3), id: \.self) { language in
                NeumorphismButton(
                    shapeType: .roundedRectangle(cornerRadius: 20),
                    normalImage: Image(language.name ?? ""),
                    selectedImage: Image(language.name ?? ""),
                    width: 40,
                    height: 40,
                    imageWidth: 30,
                    imageHeight: 30) {
                    didPressLanguage(languageName: language.name ?? "")
                }
            }
        }
    }
    
    func didPressLanguage(languageName: String){
        let selection =  LanguageSelection(rawValue: languageName)
        switch selection {
        case .Bash:
            openURL(URL(string: "https://www.gnu.org/software/bash/")!)
        case .C:
            openURL(URL(string: "https://www.w3schools.com/cs/")!)
        case .Cocoa:
            openURL(URL(string: "https://developer.apple.com/xcode/")!)
        case .CSS:
            openURL(URL(string: "https://www.w3schools.com/css/")!)
        case .PHP:
            openURL(URL(string: "https://www.php.net/")!)
        case .Dart:
            openURL(URL(string: "https://dart.dev/")!)
        case .Ruby:
            openURL(URL(string: "https://www.ruby-lang.org/en/")!)
        case .SQL:
            openURL(URL(string: "https://www.w3schools.com/sql/sql_intro.asp")!)
        case .Svelte:
            openURL(URL(string: "https://svelte.dev/")!)
        case .Lua:
            openURL(URL(string: "https://www.lua.org/")!)
        case .GraphQL:
            openURL(URL(string: "https://graphql.org/")!)
        case .Python:
            openURL(URL(string: "https://www.python.org/")!)
        case .Groovy:
            openURL(URL(string: "https://groovy-lang.org/")!)
        case .Swift:
            openURL(URL(string: "https://swift.org/")!)
        case .YAML:
            openURL(URL(string: "https://www.tutorialspoint.com/yaml/index.htm")!)
        case .Vue:
            openURL(URL(string: "https://vuejs.org/")!)
        case .HTML:
            openURL(URL(string: "https://www.w3schools.com/html/")!)
        case .JSON:
            openURL(URL(string: "https://www.w3schools.com/js/js_json_intro.asp")!)
        case .XML:
            openURL(URL(string: "https://www.w3schools.com/xml/xml_whatis.asp")!)
        case .TypeScript:
            openURL(URL(string: "https://www.typescriptlang.org/")!)
        case .Kotlin:
            openURL(URL(string: "https://kotlinlang.org/")!)
        case .INI:
            openURL(URL(string: "https://www.w3schools.io/file/ini-extension-introduction/")!)
        case .Java:
            openURL(URL(string: "https://www.java.com/en/")!)
        case .JavaScript:
            openURL(URL(string: "https://www.javascript.com/")!)
        case .none:
            break
        }
    }
}
