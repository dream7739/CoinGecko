//
//  CardPriceView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/9/24.
//

import SwiftUI

struct CardPriceView: View {
    let price: String
    let percentage: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(price)
                .bold()
            Text(percentage)
                .font(.caption).bold()
                .asSignColorText(String(percentage.prefix(1)))
            
        }
    }
}

#Preview {
    CardPriceView(
        price: "69234152",
        percentage: "+0.64%"
    )
}
