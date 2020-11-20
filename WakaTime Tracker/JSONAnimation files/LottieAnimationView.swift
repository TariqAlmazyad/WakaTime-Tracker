//
//  LottieAnimationView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/21/20.
//
//
import SwiftUI
import Lottie
struct LottieAnimationView: UIViewRepresentable {

    func makeUIView(context: Context) -> AnimationView {
        let animationView = AnimationView.init(name: "coding")
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        
    }
}

struct LottieAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimationView()
    }
}
