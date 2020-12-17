////
////  UserDetailsView.swift
////  WakaTime Tracker
////
////  Created by Tariq Almazyad on 11/19/20.
////
//
//import SwiftUI
//import NeumorphismUI
//import SDWebImageSwiftUI
//import MessageUI
//
//struct UserDetailsView: View {
//    let user: UserStats
//    @State private var progress: Double = 0.0
//    let columns: [GridItem] = [GridItem(.flexible()),
//                               GridItem(.flexible()),]
//    var body: some View{
//        ScrollView(.vertical, showsIndicators: false) {
//            neumorphism.color.edgesIgnoringSafeArea(.all)
//            
//            VStack(spacing: 12){
//                ProfileImageView(user: user)// <- end of ZStck
//                
//                UserInfoView(user: user)
//                
//                TotalHoursView(user: user)
//                
//                LazyVGrid(columns: columns, spacing: 80){
//                    ForEach(user.running_total.languages, id:\.self) { language in
//                        LanguageProgressView(user: user, language: language)
//                            .padding(.top, 40)
//                    }
//                }
//                
//            }.padding(.vertical, 60) // <- end of VStack
//            
//        }
//        .background(neumorphism.color)
//        .ignoresSafeArea()
//        
//    }
//    
//}
//struct UserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        UserDetailsView(user: .init(rank: 1,
//                                    running_total: .init(daily_average: 98,
//                                                         human_readable_daily_average: "",
//                                                         human_readable_total: "",
//                                                         total_seconds: 65,
//                                                         languages: [.init(name: "",
//                                                                           total_seconds: 32)]),
//                                    user: .init(display_name: "Tariq Almazyad",
//                                                photo: "", email: nil, location: "")))
//            .environmentObject(neumorphism)
//            .preferredColorScheme(.dark)
//        
//        
//    }
//}
//
//
//struct TotalHoursView: View {
//    let user: UserStats
//    var body: some View {
//        VStack(spacing: 8){
//            Text("Total hours coded over the last 7 days:")
//                .font(.system(size: 12, weight: .semibold, design: .default))
//                .foregroundColor(Color.gray)
//            Text(user.running_total.human_readable_total)
//                .font(.system(size: 16, weight: .bold, design: .default))
//                .foregroundColor(Color(.lightGray))
//            
//        }
//    }
//}
//
//struct UserInfoView: View {
//    let user: UserStats
//    
//    @State var result: Result<MFMailComposeResult, Error>? = nil
//    @State var isShowingMailView = false
//    
//    var body: some View {
//        VStack(spacing: 8){
//            Text("\(user.user.display_name),  rank#\(user.rank)")
//                .font(.system(size: 20, weight: .bold, design: .default))
//                .foregroundColor(Color(.white))
//            Text(user.user.email ?? "no email provided")
//                .font(.system(size: 14, weight: .semibold, design: .default))
//                .foregroundColor(Color(.lightGray))
//        }
//    }
//}
