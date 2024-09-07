//
//  RoundCornerBorder.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct RoundCornerBorder: ViewModifier {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    func body(content: Content) -> some View {
        content
            .clipShape(Circle())
            .overlay(Circle().stroke(color, lineWidth: 2.0))
    }
}

extension View {
    func asRoundCornerBorder(color: Color) -> some View {
        modifier(RoundCornerBorder(color: color))
    }
}
