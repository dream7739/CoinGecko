//
//  FavoriteView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct FavoriteView: View {
    var body: some View {
        NavigationWrapper {
            verticalFavoriteGrid()
                .asCustomNavigationBar(title: "Favorite Coin")
        }
    }
    
    func verticalFavoriteGrid() -> some View {
        ScrollView(.vertical) {
            FavoriteGridView()
        }
    }
}

struct FavoriteGridView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        LazyVGrid(columns: columns, content: {
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
            FavoriteItemView()
        })
        .padding()
    }
}

struct FavoriteItemView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(height: 160)
                .shadow(radius: 1)
            VStack {
                CoinInfoView()
                    .padding()
                Spacer()
                CoinPriceView()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
            }
        }
        .padding(3)
    }
}

#Preview {
    FavoriteView()
}
