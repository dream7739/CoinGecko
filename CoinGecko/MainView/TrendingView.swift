//
//  TrendingView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct TrendingView: View {
    @State private var trendCoinList = CoinTrendResponse(coins: [], nfts: [])
    
    private enum SectionTitle: String {
        case favorite = "My Favorite"
        case top15coin = "Top 15 Coin"
        case top7nft = "Top 7 NFT"
    }
    
    var body: some View {
        NavigationWrapper {
            ScrollView(.vertical) {
                FavoriteSectionView(SectionTitle.favorite.rawValue)
                CoinSectionView(SectionTitle.top15coin.rawValue, trendCoinList.coins)
                NFTSectionView(SectionTitle.top7nft.rawValue, trendCoinList.nfts)
            }
            .scrollIndicators(.hidden)
            .asCustomNavigationBar(title: "Crypto Coin")
        }
        .task {
            CoingeckoService.callRequest(endPoint: APIURL.trending.endPoint, response: CoinTrendResponse.self) { result in
                switch result {
                case .success(let value):
                    print(value)
                    trendCoinList = value
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct FavoriteSectionView: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title2.bold())
            ScrollView(.horizontal) {
                LazyHStack() {
                    FavoriteCardView()
                    FavoriteCardView()
                    FavoriteCardView()
                    FavoriteCardView()
                }
            }
        }
        .padding()
    }
}


struct FavoriteCardView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.1))
                .frame(width: 230, height: 170)
                .padding(.horizontal, 3)
            
            VStack(alignment: .leading) {
                CoinInfoView(
                    urlString: "",
                    coinName: "Bitcoin",
                    symbol: "BTC"
                )
                Spacer()
                CardPriceView(price: "₩12,345,678", percentage: "+0.64%")
                
            }
            .padding()
        }
    }
    
    func coinPriceView() -> some View {
        VStack(alignment: .leading) {
            Text("123456원")
            Text("+0.64%")
                .font(.caption.bold())
                .asSignColorText("+")
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
        .frame(height: 150)
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
            HStack {
                CoinIconView(urlString: trendCoin.small)
                VStack(alignment: .leading) {
                    Text(trendCoin.name)
                        .font(.callout.bold())
                    Text(trendCoin.symbol)
                        .font(.caption.bold())
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            Spacer()
            RowPriceView(
                price: trendCoin.data.priceDescription,
                percentage: trendCoin.data.priceChangePercentage.krwPercentDescription
            )
        }
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
        .frame(height: 150)
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
            HStack {
                CoinIconView(urlString: trendNFT.thumb)
                
                VStack(alignment: .leading) {
                    Text(trendNFT.name)
                        .font(.callout.bold())
                    Text(trendNFT.symbol)
                        .font(.caption.bold())
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
            Spacer()
            RowPriceView(
                price: trendNFT.data.floorPrice,
                percentage: trendNFT.data.pricePercentDescription
            )
        }
    }
}


//    #Preview {
//        TrendingView()
//    }
