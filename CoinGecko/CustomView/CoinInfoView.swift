//
//  CoinInfoView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import SwiftUI

struct CoinInfoView: View {
    let urlString: String
    let coinName: String
    let symbol: String
    
    var body: some View {
        HStack {
            CoinIconView(urlString: urlString)
            
            VStack(alignment: .leading) {
                Text(coinName)
                    .font(.callout.bold())
                    .lineLimit(2)
                Text(symbol)
                    .font(.caption.bold())
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    CoinInfoView(
        urlString: "",
        coinName: "BitCoin",
        symbol: "BTC"
    )
}
