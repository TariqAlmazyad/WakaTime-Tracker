////
////  Pass_7_DaysTimeView.swift
////  WakaTime Tracker
////
////  Created by Tariq Almazyad on 12/8/20.
////
//
//import SwiftUI
//
//struct Pass_7_DaysTimeView: View {
//    let user: UserStats
//    var body: some View {
//        ZStack {
//            Capsule(style: .circular)
//                .fill(neumorphism.color)
//                .neumorphismConcave(shapeType: .capsule, color: nil)
//                .frame(width: 140, height: 60)
//            VStack {
//                Text("Total pass 7 days:")
//                    .foregroundColor(.gray)
//                    .font(.system(size: 12, weight: .light))
//                Text(user.running_total.human_readable_total)
//                    .font(.system(size: 14, weight: .regular))
//            }
//        }
//    }
//}
//struct Pass_7_DaysTimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//            .preferredColorScheme(.dark)
//            .environmentObject(neumorphism)
//    }
//}
