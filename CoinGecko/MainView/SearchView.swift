//
//  SearchView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct SearchView: View {
    @State private var coinList: [CoinSearch] = []
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationWrapper {
            ScrollView(.vertical) {
                verticalSearchView()
            }
            .asCustomNavigationBar(title: "Search")
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "코인 이름을 입력하세요")
            .onSubmit(of: .search){
                callSearchRequest()
            }
        }
    }
    
    func verticalSearchView() -> some View {
        LazyVStack {
            ForEach($coinList, id: \.self) { $item in
                NavigationLink {
                    LazyNavigationView(ChartView(id: item.id))
                } label: {
                    SearchRowView(searchText: searchText, coin: $item)
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
    @Binding var coin: CoinSearch
    
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
            
            Button(action: {
                coin.isLike.toggle()
                
                if coin.isLike && UserDefaultsManager.favorite.count < 10 {
                    UserDefaultsManager.favorite[coin.id] = coin.id
                } else {
                    UserDefaultsManager.favorite[coin.id] = nil
                }
            }, label: {
                if let _ = UserDefaultsManager.favorite[coin.id] {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.purple)
                } else {
                    Image(systemName: "star")
                        .foregroundStyle(.purple)
                }
            
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
