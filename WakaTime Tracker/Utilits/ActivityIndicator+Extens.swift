//
//  ActivityIndicator.swift
//  WakaTime Tracker
//
//  Created by Tariq Almazyad on 11/18/20.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        //        #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return activityIndicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
    
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
            .preferredColorScheme(.dark)
    }
}

extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .day]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}



struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



extension View {
    
    /// custom function for cornerRadius to give specific value in how to curve the corner
    func cornerRadius(corners: UIRectCorner, _ radius: CGFloat) -> some View {
        clipShape(
            RoundedCorner(radius: radius, corners: corners)
        )
    }
    
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
    
}

/// to dismiss keyboard when tap outside of textfielf
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


/// to load the destination lazily without making unnecessary API request
struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

/*
 
 ///     "Mac"
 ///     "iPhone 7"
 ///     "iPhone 7 Plus"
 ///     "iPhone 8"
 ///     "iPhone 8 Plus"
 ///     "iPhone SE"
 ///     "iPhone X"
 ///     "iPhone Xs"
 ///     "iPhone Xs Max"
 ///     "iPhone Xʀ"
 ///     "iPad mini 4"
 ///     "iPad Air 2"
 ///     "iPad Pro (9.7-inch)"
 ///     "iPad Pro (12.9-inch)"
 ///     "iPad (5th generation)"
 ///     "iPad Pro (12.9-inch) (2nd generation)"
 ///     "iPad Pro (10.5-inch)"
 ///     "iPad (6th generation)"
 ///     "iPad Pro (11-inch)"
 ///     "iPad Pro (12.9-inch) (3rd generation)"
 ///     "iPad mini (5th generation)"
 ///     "iPad Air (3rd generation)"
 ///     "Apple TV"
 ///     "Apple TV 4K"
 ///     "Apple TV 4K (at 1080p)"
 ///     "Apple Watch Series 2 - 38mm"
 ///     "Apple Watch Series 2 - 42mm"
 ///     "Apple Watch Series 3 - 38mm"
 ///     "Apple Watch Series 3 - 42mm"
 ///     "Apple Watch Series 4 - 40mm"
 ///     "Apple Watch Series 4 - 44mm"
 
 */
