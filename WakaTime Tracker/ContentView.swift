//
//  ContentView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI
import NeumorphismUI

struct ContentView: View {
    
    @ObservedObject var viewModel = WakaTimeNetwork()
    @State var shouldShowFullScreenModel = false
    @State var isShowing = true
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                neumorphism.color.edgesIgnoringSafeArea(.all)
                ZStack{
                    if viewModel.isLoading {
                        HStack{
                            Spacer()
                            VStack(alignment: .center){
                                ActivityIndicator()
                                    .animation(.spring())
                                Text("Loading...")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .semibold))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(neumorphism.color)
                            .cornerRadius(80)
                            Spacer()
                        }
                    } else {
                        LazyVGrid(columns: columns, spacing: 80){
                            ForEach(viewModel.wakaTimeData?.data.prefix(10) ?? [], id: \.self) { user in
                                CellRowView(user: user)
                            }
                        }
                    }
                }.padding(.vertical, 140)
            }
            .navigationBarTitle("Top 100", displayMode: .large)
            .padding(.vertical)
            .background(neumorphism.color)
            .ignoresSafeArea()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(neumorphism)
    }
}
let neumorphism = NeumorphismManager(
    isDark: true,
    lightColor: Color(hex: "C1D2EB"),
    darkColor: Color(hex: "2C292C")
)
