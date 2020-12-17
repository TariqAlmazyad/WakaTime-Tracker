//
//  UserCellView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI
import MessageUI

struct UserCellView: View {
    let user: UserStats
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    
    var isAppAuthor: Bool {
        user.user.display_name == "Tariq Almazyad"
    }
    
    var userHasNoEmail: Bool {
        return user.user.email?.isEmpty ?? true
    }
    
    var body: some View {
        VStack{
            // rank
            HStack{
                Text("Rank #\(user.rank)")
                    .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                Spacer()
            }.padding(.horizontal)
            // profileImage
            UserImageView(user: user)
            // username
            Text(user.user.display_name)
                .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                .padding(.top)
            
            Text(isAppAuthor ? "WakaTime\nApp developer" : "")
                .foregroundColor(.white)
                .padding(.top, 4)
                .multilineTextAlignment(.center)
            
                // total 7 days capsule
            Total_7_DaysView(user: user)
            
            Text("Average Daily Time")
                .font(.system(size: 14))
                .foregroundColor(Color.white.opacity(0.5))
                .padding(.top, 2)
            Text("\(Double(user.running_total.daily_average).asString(style: .full))")
                .foregroundColor(Color(#colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)))
                .padding(.top, 1.5)
            
            // top used languages
            ZStack {
                Capsule(style: .circular)
                    .fill(neumorphism.color)
                    .neumorphismConcave(shapeType: .capsule, color: nil)
                    .frame(width: 180, height: 44)
                Text("Top used languages")
                    .font(.system(size: 14))
                    .foregroundColor(Color.white.opacity(0.5))
            }
            
            // top 3 languages.
            TopUsedLanguagesView(user: user)
            
            // show menu
        }.contextMenu(ContextMenu(menuItems: {
            Button(action: {
                self.isShowingMailView.toggle()
            }, label: {
                HStack{
                    Text(userHasNoEmail ? "\(user.user.display_name) does not have email" : "Email \(user.user.display_name)" )
                    Image(systemName: "envelope")
                }.font(.system(size: 24))
            })
        }))
        
        .disabled(userHasNoEmail)
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: $result, emailAdress: .constant(user.user.email ?? ""),
                     fullName: .constant(user.user.display_name))
        }
    }
    
    fileprivate func widthForTab(_ text: String) -> CGFloat {
        return text.widthOfString(usingFont: .systemFont(ofSize: 16, weight: .bold))
    }
    
}
struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVGridView()
            .environmentObject(neumorphism)
    }
}
