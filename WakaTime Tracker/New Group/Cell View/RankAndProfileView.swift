////
////  RankAndProfileView.swift
////  WakaTime Tracker
////
////  Created by Tariq Almazyad on 12/8/20.
////
//
//import SwiftUI
//import SDWebImageSwiftUI
//struct RankAndProfileView: View {
//    let user: UserStats
//    var body: some View{
//        HStack {
//            Text("Rank #\(user.rank)")
//                .font(.system(size: 12, weight: .light))
//                .foregroundColor(.white)
//            Spacer()
//        }.padding(.horizontal)
//        ZStack{
//            Circle()
//                .fill(neumorphism.color)
//                .frame(width: 100, height: 100)
//                .neumorphismShadow()
//            WebImage(url: URL(string: user.user.photo))
//                .resizable()
//                .indicator(.activity)
//                .scaledToFit()
//                .background(Color(#colorLiteral(red: 0.1727925241, green: 0.1605206132, blue: 0.1728563607, alpha: 1)))
//                .frame(width: 80, height: 80)
//                .overlay(
//                    Circle().stroke(Color(#colorLiteral(red: 0.1727925241, green: 0.1605206132, blue: 0.1728563607, alpha: 1)), lineWidth: 8)
//                )
//                .clipShape(Circle())
//                .cornerRadius(40)
//                .neumorphismShadow()
//        }
//    }
//}
//
//struct RankAndProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .preferredColorScheme(.dark)
//            .environmentObject(neumorphism)
//    }
//}
