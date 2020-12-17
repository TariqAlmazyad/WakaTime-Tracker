//
//  HomeVGridView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/16/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI

struct HomeVGridView: View {
    @ObservedObject private var viewModel = WakaTimeViewModel()
    @State private var searchText: String = ""
    @State private var isShowingMenu: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.screenWidth / 4, maximum: 250),
                 spacing: UIScreen.screenWidth > 600 ? 60 : 10),
        GridItem(.adaptive(minimum: UIScreen.screenWidth / 4, maximum: 250),
                 spacing: UIScreen.screenWidth > 600 ? 60 : 10),  
    ]
    
    var body: some View {
        ZStack{
            // background color
            neumorphism.color.ignoresSafeArea()
            if isShowingMenu {
                SideMenuView(isShowingMenuView: $isShowingMenu)
            }
            

            if viewModel.isLoadingUsers {
                LoadingIndicatorView()
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    // add navBar with config bytton
                    NavBarView(viewModel: .constant(viewModel), isShowingMenu: $isShowingMenu )
                        .padding(.top, 54)
                    // search bar
                    SearchBarView(text: $searchText)
                    // filter bar
                    FilterLanguagesView(selectedLanguage: $viewModel.filteredLanguage)
                        .padding(.vertical)
                    // vertical grid
                    LazyVGrid(columns: columns, spacing: 54) {
                        ForEach(viewModel.languageFilter(forFilter: viewModel.filteredLanguage)
                                    .filter{$0.user.display_name.lowercased()
                                        .contains(searchText.lowercased()) || searchText.isEmpty}, id:\.self){ user in
                            UserCellView(user: user)
                                .onTapGesture {
                                    withAnimation{
                                        viewModel.selectedUser = user
                                        viewModel.isShowingUserDetail.toggle()
                                    }
                                }
                        }
                    }.padding(.top, 44)
                    
                }.cornerRadius(isShowingMenu ? 20 : 10)
                .scaleEffect(isShowingMenu ? 0.8 : 1)
                .offset(x: isShowingMenu ? 300 : 0, y: isShowingMenu ? 44 : 0)
                .blur(radius: isShowingMenu ? 4 : 0)
                .disabled(isShowingMenu)
                
            }
            
            if let selectedUser = viewModel.selectedUser {
                UserDetailView(user: selectedUser,
                               isShowingUserDetail: $viewModel.isShowingUserDetail )
                    .opacity(viewModel.isShowingUserDetail ? 1 : 0)
            }
            
            
        }.onAppear{ viewModel.getUsers() }
        
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
        
        .ignoresSafeArea()
        .statusBarStyle(.lightContent)
        .hideKeyboardWhenScroll(interactionType: .onDrag)
        .hideKeyboardWhenTouchOutsideTextField()
    }
}


struct HomeVGridView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVGridView()
            .environmentObject(neumorphism)
    }
}
let neumorphism = NeumorphismManager(
    isDark: true,
    lightColor: Color(hex: "C1D2EB"),
    darkColor: Color(hex: "2C292C")
)

struct NavBarView: View {
    @Binding var viewModel : WakaTimeViewModel
    @Binding var isShowingMenu: Bool
    var body: some View {
        HStack{
            NeumorphismButton(
                shapeType: .roundedRectangle(cornerRadius: 100),
                normalImage: Image(systemName: "gear"),
                selectedImage: Image(systemName: "gear"),
                width: 40,
                height: 40,
                imageWidth: 30,
                imageHeight: 30,
                handler: {
                    withAnimation{
                        isShowingMenu.toggle()
                    }
                }
            )
            Spacer()
            Text("Top 100")
                .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                .font(.system(size: 20, weight: .regular, design: .rounded))
            Spacer()
            NeumorphismButton(
                shapeType: .roundedRectangle(cornerRadius: 100),
                normalImage: Image(systemName: "arrow.triangle.2.circlepath"),
                selectedImage: Image(systemName: "arrow.triangle.2.circlepath"),
                width: 40,
                height: 40,
                imageWidth: 30,
                imageHeight: 30,
                handler: {
                    withAnimation{
                        viewModel.getUsers()
                    }
                }
            )
        }.padding(.all)
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
