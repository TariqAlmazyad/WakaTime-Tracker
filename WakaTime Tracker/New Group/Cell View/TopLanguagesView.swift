//
//  TopLanguagesView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/8/20.
//

import SwiftUI
import NeumorphismUI

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
        case .All:
            Print("")
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

struct TopLanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(neumorphism)
    }
}
