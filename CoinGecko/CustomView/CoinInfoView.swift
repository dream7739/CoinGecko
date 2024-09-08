//
//  CoinInfoView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import SwiftUI

struct CoinInfoView: View {
    var body: some View {
        HStack {
            Image(systemName: "heart")
                .frame(width: 40, height: 40)
                .background(.orange)
            
            VStack(alignment: .leading) {
                Text("Bitcoin")
                    .font(.callout.bold())
                Text("BTC")
                    .font(.caption.bold())
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
    }
}

#Preview {
    CoinInfoView()
}
