//
//  NavigationBarModifier.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct NavigationBarModifier<Leading: View, Trailing: View> : ViewModifier {
    let leading: Leading
    let trailing: Trailing
    
    init(@ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        leading
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        trailing
                    }
                }
                
        } else {
            content
                .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
}

extension View {
    func asNavigationBarItem(
        @ViewBuilder leading: () -> some View,
        @ViewBuilder trailing: () -> some View
    ) -> some View {
        modifier(NavigationBarModifier(leading: leading, trailing: trailing))
    }
}
