//
//  SearchBarView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/16/20.
//

import SwiftUI
import NeumorphismUI


struct SearchBarView: View {
    @Binding var text: String
    var body: some View {
        ZStack {
            neumorphism.color.ignoresSafeArea()
            Capsule(style: .circular)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .capsule, color: nil)
            HStack{
                TextField("Search...", text: $text)
                    .foregroundColor(.white)
                    .padding(8)
                    .padding(.horizontal, 24)
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                        },
                        alignment: .leading
                    )
            }.padding(.horizontal, 10)
        }.frame(width: UIScreen.screenWidth / 2 + 100, height: 50)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SearchBarView(text: .constant(""))
                .preferredColorScheme(.dark)
                .environmentObject(neumorphism)
        }
    }
}
