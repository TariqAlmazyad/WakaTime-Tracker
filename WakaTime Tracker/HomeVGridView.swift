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
            // scrollView
            ScrollView(.vertical, showsIndicators: false){
                // add navBar with config bytton
                NavBarView()
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
                    }
                }.padding(.top, 44)
            }
            
        }.onAppear{
            viewModel.getUsers()
        }
        
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

struct NavBarView: View {
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
                    print("did select")
                }
            )
            Spacer()
            Text("Top 100")
                .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                .font(.system(size: 20, weight: .regular, design: .rounded))
                .padding(.trailing, 64)
            Spacer()
        }.padding(.all)
    }
}
