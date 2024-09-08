//
//  SearchView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct SearchView: View {
    @State var coinList: [CoinSearch] = []
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
                callSearchRequest()
            }
        }
    }
    
    func verticalSearchView() -> some View {
        LazyVStack {
            ForEach(coinList, id: \.self) { item in
                NavigationLink {
                    LazyNavigationView(ChartView())
                } label: {
                    SearchRowView(coin: item, searchText: searchText)
                }
            }
        }
    }
    
    func callSearchRequest() {
        CoingeckoService.callRequest(endPoint: APIURL.search(query: searchText).endPoint,
                                     response: CoinSearchResponse.self,
                                     completion: { result in
            switch result {
            case .success(let value):
                coinList = value.coins
            case .failure(let error):
                print(error)
            }
        })
    }
    
}

struct SearchRowView: View {
    let searchText: String
    let coin: CoinSearch
    
    init(coin: CoinSearch, searchText: String) {
        self.coin = coin
        self.searchText = searchText
    }
    
    var body: some View {
        HStack {
            CoinIconView(urlString: coin.thumb)
            
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
