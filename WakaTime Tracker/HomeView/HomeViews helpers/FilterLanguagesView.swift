//
//  FilterLanguagesView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI

struct FilterLanguagesView: View {
    
    private let optionWidth = UIScreen.main.bounds.width /  CGFloat(LanguageSelection.allCases.count)
    @Binding var selectedLanguage: LanguageSelection
    @Namespace private var animation
    var body: some View {
        ZStack {
            neumorphism.color.ignoresSafeArea()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(LanguageSelection.allCases, id:\.self) { language in
                        FilterCellView(selectedLanguage: $selectedLanguage, language: language )
                    }
                }.padding(.horizontal)
            }
        }
    }
    
}

struct FilterLanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVGridView()
            .environmentObject(neumorphism)
    }
}

struct FilterCellView: View {
    @Binding var selectedLanguage: LanguageSelection
    let language: LanguageSelection
    var body: some View {
        Button(action: {
            withAnimation{
                selectedLanguage = language
            }
        }, label: {
            VStack {
                Text(language.languageName)
                    .font(.subheadline)
                    .foregroundColor(selectedLanguage == language ? Color(#colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)) : Color(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1)))
                    .frame(width: widthForTab(language.rawValue) + 40, height: 20)
                Rectangle()
                    .foregroundColor(selectedLanguage == language ? Color(#colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)) : .clear)
                    .frame(width: widthForTab(language.rawValue), height: 3)
            }
        })
    }
    fileprivate func widthForTab(_ text: String) -> CGFloat {
        return text.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .bold))
    }
}
