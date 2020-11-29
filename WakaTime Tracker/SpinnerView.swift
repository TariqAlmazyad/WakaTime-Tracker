//
//  SpinnerView.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/24/20.
//
import SwiftUI

public struct SpinnerView: UIViewRepresentable {
  public typealias UIViewType = UIActivityIndicatorView
  
  public init(isAnimating: Binding<Bool>, style: UIActivityIndicatorView.Style) {
    self._isAnimating = isAnimating
    self.style = style
  }
  
  @Binding var isAnimating: Bool
  let style: UIActivityIndicatorView.Style

  public func makeUIView(context: UIViewRepresentableContext<SpinnerView>) -> UIActivityIndicatorView {
    return UIActivityIndicatorView(style: style)
  }
  
  public func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<SpinnerView>) {
    if isAnimating {
      uiView.isUserInteractionEnabled = false
      uiView.startAnimating()
    } else {
      uiView.isUserInteractionEnabled = true
      uiView.stopAnimating()
    }
  }
}
