//
//  ContentView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

//SwiftUI TabBar가 아니라 TabView
//tintColor -> tint
struct ContentView: View {
    var body: some View {
        TabView {
            TrendingView()
                .tabItem {
                    Label("", systemImage: "chart.line.uptrend.xyaxis")
                }
            SearchView()
                .tabItem {
                    Label("", systemImage: "magnifyingglass")
                }
            FavoriteView()
                .tabItem {
                    Label("", systemImage: "heart")
                }
        }
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}
