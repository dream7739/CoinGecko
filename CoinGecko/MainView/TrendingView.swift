//
//  TrendingView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct TrendingView: View {
    @State private var trendCoinList = CoinTrendResponse(coins: [], nfts: [])
    @State private var favoriteCoinList: [CoinMarket] = []
    
    private enum SectionTitle: String {
        case favorite = "My Favorite"
        case top15coin = "Top 15 Coin"
        case top7nft = "Top 7 NFT"
    }
    
    var body: some View {
        NavigationWrapper {
            ScrollView(.vertical) {
                FavoriteSectionView(SectionTitle.favorite.rawValue, favoriteCoinList)
                CoinSectionView(SectionTitle.top15coin.rawValue, trendCoinList.coins)
                NFTSectionView(SectionTitle.top7nft.rawValue, trendCoinList.nfts)
            }
            .scrollIndicators(.hidden)
            .asCustomNavigationBar(title: "Crypto Coin")
        }
        .task {
            callTrendingAPI()
            callFavoriteMarketAPI()
        }
    }
    
    private func callTrendingAPI() {
        CoingeckoService.callRequest(endPoint: APIURL.trending.endPoint, response: CoinTrendResponse.self) { result in
            switch result {
            case .success(let value):
                trendCoinList = value
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func callFavoriteMarketAPI() {
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

struct FavoriteSectionView: View {
    let title: String
    let favoriteCoinList: [CoinMarket]
    
    init(_ title: String, _ favoriteCoinList: [CoinMarket]) {
        self.title = title
        self.favoriteCoinList = favoriteCoinList
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2.bold())
            ScrollView(.horizontal) {
                LazyHStack() {
                    ForEach(favoriteCoinList, id: \.self) { item in
                        FavoriteCardView(coin: item)
                    }
                }
            }
        }
        .padding()
    }
}


struct FavoriteCardView: View {
    let coin: CoinMarket
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.1))
                .frame(width: 230, height: 170)
                .padding(.horizontal, 3)
            
            VStack(alignment: .leading) {
                CoinInfoView(
                    urlString: coin.image,
                    coinName: coin.name,
                    symbol: coin.symbol
                )
                Spacer()
                CardPriceView(
                    viewType: .trend,
                    price: coin.priceDescription,
                    percentage: coin.percentDescription
                )
            }
            .padding()
            .frame(maxWidth: 230)
        }
    }
}



//Top15 Coin Section
struct CoinSectionView: View {
    let title: String
    let items: [CoinTrend]
    
    init(_ title: String, _ items: [CoinTrend]) {
        self.title = title
        self.items = items
    }
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2.bold())
            ScrollView(.horizontal) {
                horizontalGrid()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
        }
        .padding()
    }
    
    func horizontalGrid() -> some View {
        LazyHGrid(rows: rows, alignment: .center) {
            ForEach(0..<items.count, id: \.self) { index in
                CoinRowView(rank: index + 1, trendCoin: items[index].item)
            }
        }
        .frame(maxHeight: .infinity)
        .scrollTargetLayout()
    }
}

//Top15 Coin Row
struct CoinRowView: View {
    let rank: Int
    let trendCoin: CoinTrendItem
    
    var body: some View {
        HStack {
            Text("\(rank)")
                .font(.title2.bold())
            CoinInfoView(
                urlString: trendCoin.small,
                coinName: trendCoin.name,
                symbol: trendCoin.symbol
            )
            Spacer()
            RowPriceView(
                price: trendCoin.data.priceDescription,
                percentage: trendCoin.data.priceChangePercentage.krwPercentDescription
            )
        }
        .frame(width: UIScreen.main.bounds.width - 100)
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
    }
    
}


//Top7 NFT Section
struct NFTSectionView: View {
    let title: String
    let items: [NFTTrend]
    
    init(_ title: String, _ items: [NFTTrend]) {
        self.title = title
        self.items = items
    }
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2.bold())
            ScrollView(.horizontal) {
                horizontalGrid()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
        }
        .padding()
    }
    
    func horizontalGrid() -> some View {
        LazyHGrid(rows: rows, alignment: .center) {
            ForEach(0..<items.count, id: \.self) { index in
                NFTRowView(rank: index + 1, trendNFT: items[index])
                    .padding(.horizontal, 3)
            }
        }
        .frame(maxHeight: .infinity)
        .scrollTargetLayout()
    }
}

struct NFTRowView: View {
    let rank: Int
    let trendNFT: NFTTrend
    
    var body: some View {
        HStack {
            Text("\(rank)")
                .font(.title2.bold())
            CoinInfoView(
                urlString: trendNFT.thumb,
                coinName: trendNFT.name,
                symbol: trendNFT.symbol
            )
            Spacer()
            RowPriceView(
                price: trendNFT.data.floorPrice,
                percentage: trendNFT.data.pricePercentDescription
            )
        }
        .frame(width: UIScreen.main.bounds.width - 100)
        .padding(.horizontal, 5)
        .padding(.vertical, 5)
    }
}


//    #Preview {
//        TrendingView()
//    }
