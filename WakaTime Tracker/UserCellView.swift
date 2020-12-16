//
//  UserCellView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI

struct UserCellView: View {
    let user: UserStats
    var body: some View {
        VStack {
            HStack{
                Text("Rank #\(user.rank)")
                    .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                Spacer()
            }.padding(.horizontal)
            ZStack {
                NeumorphismButton(
                    shapeType: .roundedRectangle(cornerRadius: 100),
                    normalImage: Image(systemName: ""),
                    selectedImage: Image(systemName: ""),
                    width: 90,
                    height: 90,
                    handler: {
                        print("did select")
                    }
                )
                WebImage(url: URL(string: user.user.photo))
                    .resizable()
                    .indicator(.activity)
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
            }.frame(width: 90, height: 90)
            .padding(.top, 12)
            Text(user.user.display_name)
                .foregroundColor(Color(#colorLiteral(red: 0.6475275159, green: 0.6230242848, blue: 0.647654593, alpha: 1)))
                .frame(width: UIScreen.screenWidth / 2.4)
                .padding(.top)
        }
    }
}
struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVGridView()
    }
}
