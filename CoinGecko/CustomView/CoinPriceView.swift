//
//  CoinPriceView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct CoinPriceView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("₩69,234,245")
                .bold()
            Text("+0.64%")
                .font(.callout)
                .bold()
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    CoinPriceView()
}
