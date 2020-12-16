//
//  Utilis.swift
//  Twitter swiftUI
//
//  Created by Tariq Almazyad on 12/10/20.
//

import SwiftUI


class HostingController<Content: View>: UIHostingController<Content> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.statusBarStyle
    }
}


extension String {
    /// to get the width of textField based on the font
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
}



///By wrapping views in a RootView, they will become the app's main / primary view. This will enable setting the statusBarStyle.
struct RootView<Content: View> : View {
    var content: Content
    
    init(@ViewBuilder content: () -> (Content)) {
        self.content = content()
    }
    
    var body:some View {
        EmptyView()
            .onAppear {
                UIApplication.shared.setHostingController(rootView: AnyView(content))
            }
    }
}

extension View {
    
    func tabViewPagingModifier(currentPageIndicatorTintColor: Color, pageIndicatorTintColor: Color) -> some View{
        return self.onAppear{
            UIPageControl.appearance().currentPageIndicatorTintColor = currentPageIndicatorTintColor.uiColor()
            UIPageControl.appearance().pageIndicatorTintColor = pageIndicatorTintColor.uiColor().withAlphaComponent(0.4)
        }
    }
    
    ///Sets the status bar style color for this view.
    func statusBarStyle(_ style: UIStatusBarStyle) -> some View {
        UIApplication.statusBarStyleHierarchy.append(style)
        //Once this view appears, set the style to the new style. Once it disappears, set it to the previous style.
        return self.onAppear {
            UIApplication.setStatusBarStyle(style)
        }.onDisappear {
            guard UIApplication.statusBarStyleHierarchy.count > 1 else { return }
            let style = UIApplication.statusBarStyleHierarchy[UIApplication.statusBarStyleHierarchy.count - 1]
            UIApplication.statusBarStyleHierarchy.removeLast()
            UIApplication.setStatusBarStyle(style)
        }
    }
    /// hide keyboard when touch outside of textField. 
    func hideKeyboardWhenTouchOutsideTextField() -> some View {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    /// Add ability to dismiss keyboard when adding ScrollView to View
    func hideKeyboardWhenScroll(interactionType:  UIScrollView.KeyboardDismissMode) -> some View {
        return self.onAppear{
            UIScrollView.appearance().keyboardDismissMode = interactionType
        }
    }
    
    /// to modify  the navBar attributes , title , bar color , and Translucent
    func navBarModifier(largeTitleColor: Color, smallTitleColor: Color, isTranslucent: Bool, barStyle:  UIBarStyle   ) -> some View {
        return self.onAppear{
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: largeTitleColor.uiColor()]
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: smallTitleColor.uiColor()]
            UINavigationBar.appearance().isTranslucent = isTranslucent
            UINavigationBar.appearance().barStyle = barStyle
        }
    }
    
    /// manage cell background color and List View color
    func listBackgroundModifier(backgroundColor: Color) -> some View {
        return self.onAppear{
            UITableView.appearance().backgroundColor = backgroundColor.uiColor()
        }
    }
}

extension UIApplication {
    static var hostingController: HostingController<AnyView>? = nil
    
    static var statusBarStyleHierarchy: [UIStatusBarStyle] = []
    static var statusBarStyle: UIStatusBarStyle = .darkContent
    
    ///Sets the App to start at rootView
    func setHostingController(rootView: AnyView) {
        let hostingController = HostingController(rootView: AnyView(rootView))
        windows.first?.rootViewController = hostingController
        UIApplication.hostingController = hostingController
    }
    
    static func setStatusBarStyle(_ style: UIStatusBarStyle) {
        statusBarStyle = style
        hostingController?.setNeedsStatusBarAppearanceUpdate()
    }
}


extension Color {
 
    func uiColor() -> UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}

enum SmallDevices: String, CaseIterable {
    case iPhone7 = "iPhone 7"
    case iPhone8 = "iPhone 8"
    case iPhoneSE = "iPhone SE"
    case iPhoneX = "iPhone X"
    case iPhoneXs = "iPhone Xs"
    
    var currentDevice: String {
        switch self {
        case .iPhone7: return  "iPhone 7"
        case .iPhone8: return  "iPhone 8"
        case .iPhoneSE: return  "iPhone SE"
        case .iPhoneX: return  "iPhone X"
        case .iPhoneXs: return  "iPhone Xs"
        }
    }
}

enum LargeDevices: String, CaseIterable {
    case iPhone7Plus = "iPhone 7 Plus"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneXsMax = "iPhone Xs Max"
    
    var currentDevice: String {
        switch self {
        case .iPhone7Plus: return "iPhone 7 Plus"
        case .iPhone8Plus: return "iPhone 8 Plus"
        case .iPhoneXsMax: return "iPhone Xs Max"
        }
    }
}


///// Add ability to dismiss keyboard when adding scrollable view
//struct KeyboardDismissal: ViewModifier {
//    @Binding var interactionType:  UIScrollView.KeyboardDismissMode
//    func body(content: Content) -> some View {
//        content
//            .onAppear {
//                UIScrollView.appearance().keyboardDismissMode = interactionType
//            }
//    }
//}


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
