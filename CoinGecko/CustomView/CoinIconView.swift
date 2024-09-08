//
//  CoinIconView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import SwiftUI

struct CoinIconView: View {
    let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { result in
            switch result {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
            case .failure:
                Image(systemName: "star")
            @unknown default:
                Image(systemName: "star")
            }
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
    CoinIconView(urlString: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400")
}
