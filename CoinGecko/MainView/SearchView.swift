//
//  SearchView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct SearchView: View {
    @State var coinList: [Coin] = []
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationWrapper {
            ScrollView(.vertical) {
                verticalSearchView()
            }
            .navigationTitle("Search")
            .asNavigationBarItem {
                EmptyView()
            } trailing: {
                ProfileImageView()
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "코인 이름을 입력하세요")
            .onSubmit(of: .search){
                CoingeckoService.callSearchRequest(query: searchText) { response in
                    print(response)
                    coinList = response.coins
                }
            }
        }
    }
    
    func verticalSearchView() -> some View {
        LazyVStack {
            ForEach(coinList, id: \.self) { item in
                SearchRowView(coin: item, searchText: searchText)
            }
        }
    }
    
}

struct SearchRowView: View {
    let searchText: String
    let coin: Coin
    
    init(coin: Coin, searchText: String) {
        self.coin = coin
        self.searchText = searchText
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.thumb)) { result in
                switch result {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                case .failure:
                    Image(systemName: "star")
                @unknown default:
                    Image(systemName: "star")
                }}
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(coin.name.toAttributedString(searchText))
                Text(coin.symbol)
                    .font(.caption.bold())
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "star")
                    .foregroundStyle(.purple)
            })
        }
        .frame(height: 50)
        .padding(.vertical, 3)
        .padding(.horizontal, 10)
    }
}

#Preview {
    SearchView()
}
