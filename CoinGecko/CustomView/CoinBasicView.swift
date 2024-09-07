//
//  CoinBasicView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct CoinBasicView: View {
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
    CoinBasicView()
}
