//
//  CustomNavigationBar.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import SwiftUI

//Large Title + ProfileImageView
struct CustomNavigationBar: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        content
            .asNavigationBarItem {
                EmptyView()
            } trailing: {
                ProfileImageView()
            }
            .navigationTitle(title)
    }
}

extension View {
    func asCustomNavigationBar(title: String) -> some View {
        modifier(CustomNavigationBar(title: title))
    }
}
