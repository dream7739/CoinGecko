//
//  TrendingView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct TrendingView: View {
    
    private enum SectionTitle: String {
        case top15coin = "Top 15 Coin"
        case top7nft = "Top 7 NFT"
    }
    
    var body: some View {
        NavigationWrapper {
            ScrollView(.vertical) {
                horizontalCardView()
                TrendingRankView(SectionTitle.top15coin.rawValue)
                TrendingRankView(SectionTitle.top7nft.rawValue)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Crypto Coin")
            .asNavigationBarItem {
                EmptyView()
            } trailing: {
                ProfileImageView()
            }
            
        }
    }
    
    func horizontalCardView() -> some View {
        VStack(alignment: .leading) {
            Text("My Favorite")
                .font(.title2.bold())
            ScrollView(.horizontal) {
                LazyHStack() {
                    TrendingCardView()
                    TrendingCardView()
                    TrendingCardView()
                    TrendingCardView()
                }
            }
        }
        .padding()
    }
}


struct TrendingCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.15))
                .frame(width: 230, height: 170)
                .padding(.horizontal, 3)
            
            VStack(alignment: .leading) {
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
                Spacer()
                CoinPriceView()
            }
            .padding()
        }
    }
}
    
    
    struct TrendingRankView: View {
        let title: String
        let items = 1...15
        
        init(_ title: String) {
            self.title = title
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
                ForEach(items, id: \.self) { item in
                    TrendingRowView()
                        .padding(.horizontal, 3)
                }
            }
            .frame(height: 150)
            .scrollTargetLayout()
        }
    }
    
    struct TrendingRowView: View {
        var body: some View {
            HStack {
                Text("1")
                    .font(.title2.bold())
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
                Spacer()
                CoinPriceView()
            }
        }
    }
    
    
    #Preview {
        TrendingView()
    }
