//
//  ContentView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI
import NeumorphismUI
import LNPopupUI

struct ContentView: View {
    
    @ObservedObject var viewModel = WakaTimeNetwork()
    @State var shouldShowFullScreenModel = false
    @State var isShowing = true
    @State var isBarPresented = true
    @State var isPopupOpen = false
    
    @State var user: UserStats?
    
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
                            ForEach(viewModel.wakaTimeData?.data ?? [], id: \.self) { user in
                                CellRowView(user: user)
                                    .onTapGesture {
                                        self.user = user
                                        self.isPopupOpen.toggle()
                                    }
                                  
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
        
        .popup(isBarPresented: $isBarPresented, isPopupOpen: $isPopupOpen, popupContent: {
            if let user = user {
                UserDetailsView(user: user) /* <-- pass user here as well*/
            } else {
                Text("Hello world")
                    .foregroundColor(.white)
            }
            
        })
        .popupBarCustomView(wantsDefaultTapGesture: false, wantsDefaultPanGesture: false, wantsDefaultHighlightGesture: false) {
            HStack(spacing: 24){
                Text("Choose any user to\ndisplay coding activity")
                    .font(.system(size: 16, weight: .light))
                    .foregroundColor(.white)
                    .frame(height: 40)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .padding(6)
                    .padding(.top, 8)
                
                Button(action: {
                    self.isPopupOpen.toggle()
                    
                }, label: {
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                })
            }
        }
        .popupBarStyle(.default)
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

