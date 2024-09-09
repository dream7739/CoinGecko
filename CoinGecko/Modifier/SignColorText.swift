//
//  SignColorText.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/9/24.
//

import SwiftUI

struct SignColorText: ViewModifier {
    let sign: String
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(sign == "+" ? .red : .blue)
    }
}

struct SignColorBackgroudText: ViewModifier {
    let sign: String
    
    func body(content: Content) -> some View {
        content
            .asSignColorText(sign)
            .padding()
            .background(sign == "+" ? .red : .blue).opacity(0.3)
    }
}

extension View {
    func asSignColorText(_ sign: String) -> some View {
        modifier(SignColorText(sign: sign))
    }
    
    func asSignColorBackgroundText(_ sign: String) -> some View {
        modifier(SignColorBackgroudText(sign: sign))
    }
}
