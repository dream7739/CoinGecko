//
//  FavoriteView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct FavoriteView: View {
    @State private var favoriteCoinList: [CoinMarket] = []
    
    var body: some View {
        NavigationWrapper {
            verticalFavoriteGrid()
                .asCustomNavigationBar(title: "Favorite Coin")
        }.task {
            callFetchMarketAPI()
        }
    }
    
    private func verticalFavoriteGrid() -> some View {
        ScrollView(.vertical) {
            FavoriteGridView(favoriteCoinList: favoriteCoinList)
        }
    }
    
    private func callFetchMarketAPI() {
        let favoriteIds = UserDefaultsManager.favorite.map { $0.key }.joined(separator: ",")
        CoingeckoService.callRequest(
            endPoint: APIURL.market(ids: favoriteIds).endPoint,
            response: [CoinMarket].self) { result in
                switch result {
                case .success(let value):
                    favoriteCoinList = value
                case .failure(let error):
                    print(error)
                }
            }
    }
}

struct FavoriteGridView: View {
    let favoriteCoinList: [CoinMarket]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, content: {
            ForEach(favoriteCoinList, id: \.self) { item in
                FavoriteItemView(coin: item)
            }
          
        })
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct FavoriteItemView: View {
    let coin: CoinMarket
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(color: .gray.opacity(0.3), radius: 5)
            VStack {
                CoinInfoView(
                    urlString: coin.image,
                    coinName: coin.name,
                    symbol: coin.symbol
                )
                
                Spacer()
                
                HStack {
                    Spacer()
                    CardPriceView(
                        viewType: .favorite,
                        price: coin.priceDescription,
                        percentage: coin.percentDescription
                    )
                }
            }
            .padding()
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
    }
}

#Preview {
    FavoriteView()
}
