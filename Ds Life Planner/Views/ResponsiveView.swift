//
//  ResponsiveView.swift
//  ResponsiveUI
//
//  Created by BoiseITGuru on 3/29/23.
//

import SwiftUI

// MARK: Custom View Which WIll GIve Useful Properties for Adotable UI
struct ResponsiveView<Content: View>: View {
    var content: (Properties)-> Content
    
    init(@ViewBuilder content: @escaping (Properties)->Content) {
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let isLandscape = size.width > size.height
            //TODO: FIX THIS
//            let isiPad = true
            let isiPad = UIDevice.current.userInterfaceIdiom == .pad
            let isMaxSplit = isSplit() && size.width < 400
            let properties = Properties(isLandscape: isLandscape, isiPad: isiPad, isSplit: isSplit(), isMaxSplit: isMaxSplit, size: size)
            
            content(properties)
                .frame(width: size.width, height: size.height)
        }
    }
    
    // MARK: Simple Way to Find if the app is in Split View
    func isSplit() -> Bool {
        //TODO: FIX THIS
//        return false
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }

        return screen.windows.first?.frame.size != screen.screen.bounds.size
    }
}

struct ResponsiveView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Properties {
    var isLandscape: Bool
    var isiPad: Bool
    var isSplit: Bool
    // MARK: If the App size is reduced more than 1/3 in splite mode on iPad
    var isMaxSplit: Bool
    var size: CGSize
}
