//
//  UserDetailView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI
struct UserDetailView: View {
    
    let user: UserStats
    @Binding var isShowingUserDetail: Bool
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.screenWidth / 4, maximum: 250),
                 spacing: UIScreen.screenWidth > 600 ? 60 : 10),
        GridItem(.adaptive(minimum: UIScreen.screenWidth / 4, maximum: 250),
                 spacing: UIScreen.screenWidth > 600 ? 60 : 10),
    ]
    
    var body: some View {
        ZStack {
            neumorphism.color.ignoresSafeArea()
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false) {
                // nav view with username and xmark
                ButtonDismissView(isShowingUserDetail: $isShowingUserDetail)
                    .padding([.top, .horizontal], 34)
                    .padding(.top, 34)
                
                // profile image
                UserImageView(user: user)
                    .frame(width: 100, height: 100)
                // username
                VStack(spacing: 12){
                    Text("\(user.user.display_name)\nrank#\(user.rank)")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(Color(.white))
                        .multilineTextAlignment(.center)
                    // email text
                    Text(user.user.email ?? "\(user.user.display_name) does not have an email")
                        .font(.system(size: 14, weight: .semibold, design: .default))
                        .foregroundColor(Color(.lightGray))
                }.padding(.top)
                
                VStack(spacing: 8){
                    Text("Total hours coded over the last 7 days:")
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .foregroundColor(Color.gray)
                    Text(user.running_total.human_readable_total)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(Color(.lightGray))
                }.padding(.top)
                
                LazyVGrid(columns: columns, spacing: 80){
                    ForEach(user.running_total.languages, id:\.self) { language in
                        LanguageProgressView(user: user, language: language)
                            .foregroundColor(.white)
                    }
                }.padding(.vertical, 24)
                .padding(.top, 24)
                
            }
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //        UserDetailView(user: user, isShowingUserDetail: .constant(true))
        HomeVGridView()
            .environmentObject(neumorphism)
    }
}

let user = UserStats(rank: 0,
                     running_total: .init(daily_average: 0,
                                          human_readable_daily_average: "",
                                          human_readable_total: "",
                                          total_seconds: 0.0,
                                          languages: [.init(name: "", total_seconds: 0.0)]),
                     user: .init(display_name: "Tariq Almazyad", photo: "", email: "", location: ""))

struct ButtonDismissView: View {
    @Binding var isShowingUserDetail: Bool
    var body: some View {
        HStack{
            Spacer()
            Button(action: {
                withAnimation{
                    isShowingUserDetail.toggle()
                }
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 24))
                    .foregroundColor(Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)))
                    .padding(.trailing)
            })
        }
    }
}
