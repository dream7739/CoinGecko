//
//  RowPriceView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/9/24.
//

import SwiftUI

struct RowPriceView: View {
    let price: String
    let percentage: String
    
    var body: some View {
        VStack(alignment: .trailing) {
            Text(price)
                .font(.footnote)
            Text(percentage)
                .font(.caption)
                .asSignColorText(String(percentage.prefix(1)))
        }
    }
}

#Preview {
    RowPriceView(
        price: "$0.4175",
        percentage: "+1.38%"
    )
}
