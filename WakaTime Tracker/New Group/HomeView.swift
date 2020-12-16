//
//  ContentView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI
import NeumorphismUI
import LNPopupUI

struct HomeView: View {
    
    @ObservedObject var viewModel = WakaTimeNetwork()
    @State private var shouldShowFullScreenModel = false
//    @State private var isShowing = true
    @State private var isBarPresented = true
    @State private var isPopupOpen = false
    @State private var user: UserStats?
    @State private var searchedUser: String = ""
    @State private var isSearching: Bool = false
    
    
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),]
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                neumorphism.color.edgesIgnoringSafeArea(.all)

                SearchBarView1(searchedUser: $searchedUser,
                              isSearching: $isSearching,
                              isBarPresented: $isBarPresented)
                    .offset(y: UIScreen.screenHeight < 800 ? 86 : 110)
                 
                ZStack{
                    if viewModel.isLoading {
                        LoadingIndicatorView()
                    } else {
   
                        LazyVGrid(columns: columns, spacing: 80){
                            ForEach(viewModel.wakaTimeData?.data.filter({$0.user.display_name.lowercased().contains(searchedUser.lowercased()) || searchedUser.isEmpty}
                            ) ?? [], id: \.self) { user in
                                CellRowView(user: user)
                                    .onTapGesture {
                                        self.user = user
                                        self.isPopupOpen.toggle()
                                        self.isBarPresented = true
                                    }
                                    
                            }
                        }
                       
                    }
                }.navigationBarTitle("Top 100", displayMode: isSearching ? .inline : .large )
                .padding(.vertical, 140)
                .padding(.horizontal, 2)
            }
            .padding(.vertical)
            .background(neumorphism.color)
            .ignoresSafeArea()
            
        }
        
        .statusBarStyle(.lightContent)
        
        .popup(isBarPresented: $isBarPresented, isPopupOpen: $isPopupOpen, onClose: {
            self.user = nil
        } , popupContent: {
            if let user = user {
                UserDetailsView(user: user) /* <-- pass user here as well*/
            } else {
                WakaTimeRefView()
            }
            
        })
        .popupCloseButtonStyle(.round)
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
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color(.lightGray))
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(neumorphism)
    }
}
let neumorphism = NeumorphismManager(
    isDark: true,
    lightColor: Color(hex: "C1D2EB"),
    darkColor: Color(hex: "2C292C")
)


struct SearchBarView1: View {
    @Binding var searchedUser: String
    @Binding var isSearching: Bool
    @Binding var isBarPresented: Bool
    var body: some View{
        ZStack{
            Capsule(style: .circular)
                .fill(neumorphism.color)
                .neumorphismConcave(shapeType: .capsule, color: nil)
            
            TextField("Search for developer...", text: $searchedUser, onEditingChanged: { isEditing in
                withAnimation{
                    isBarPresented = false
                    isSearching = true
                }
            }, onCommit: {
                
                withAnimation{
                    isBarPresented = true
                    isSearching = false
                }
            })
            
                .foregroundColor(.white)
                .padding(.leading, 40)
                .onTapGesture {
                    isSearching = true
                }
            
            
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
        .background(neumorphism.color)
        .overlay(
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                Spacer()
                if isSearching{
                    Button(action: {
                        searchedUser = ""
                        isSearching = false
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .foregroundColor(.white)
                    })
                }
            }.padding(.horizontal)
        )
    }
}

struct LoadingIndicatorView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack(alignment: .center){
                ActivityIndicator()
                //                                Text("\(String(format: "%.2f", viewModel.progress * 100))")
                Text("Loading...")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
            .frame(width: 300, height: 140)
            .padding()
            .background(neumorphism.color)
            .cornerRadius(80)
            Spacer()
        }
    }
}
