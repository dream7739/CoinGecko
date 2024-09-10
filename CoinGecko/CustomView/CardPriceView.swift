//
//  CardPriceView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/9/24.
//

import SwiftUI

struct CardPriceView: View {
    enum ViewType {
        case trend
        case favorite
        
        var alignment: HorizontalAlignment {
            switch self {
            case .trend:
                return .leading
            case .favorite:
                return .trailing
            }
        }
    }
    
    let viewType: ViewType
    let price: String
    let percentage: String
    
    var body: some View {
        VStack(alignment: viewType.alignment, spacing: 6) {
            Text(price)
                .font(.subheadline)
                .bold()
            switch viewType {
            case .trend:
                Text(percentage)
                    .font(.caption).bold()
                    .asSignColorText(String(percentage.prefix(1)))
            case .favorite:
                Text(percentage)
                    .font(.caption).bold()
                    .asSignColorBackgroundText(String(percentage.prefix(1)))
            }
            
        }
    }
}

#Preview {
    CardPriceView(
        viewType: .trend,
        price: "69234152",
        percentage: "+0.64%"
    )
}
