//
//  LottieAnimationView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/21/20.
//
//
import SwiftUI
import Lottie
import UIKit
struct LottieAnimationView: UIViewRepresentable {
    
    var fileName: String
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView.init(name: fileName)
        animationView.play()
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
         
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {

    }
}

struct LottieAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimationView(fileName: "coding" )
    }
}
