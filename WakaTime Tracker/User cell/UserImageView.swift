//
//  UserImageView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 12/17/20.
//

import SwiftUI
import NeumorphismUI
import SDWebImageSwiftUI
struct UserImageView: View {
    let user: UserStats
    var body: some View {
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
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        }
        .padding(.top, 12)
        .frame(width: 90, height: 90)
    }
}

struct UserImageView_Previews: PreviewProvider {
    static var previews: some View {
        HomeVGridView()
            .environmentObject(neumorphism)
    }
}
