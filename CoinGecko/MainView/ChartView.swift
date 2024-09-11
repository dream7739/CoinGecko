//
//  ChartView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State var coinMarket = CoinMarket(
        id: "",
        symbol: "",
        name: "",
        image: "",
        currentPrice: 0,
        high24H: 0,
        low24H: 0,
        priceChangePercentage24H: 0,
        ath: 0,
        athDate: "",
        atl: 0,
        atlDate: "",
        lastUpdated: "",
        sparkLine7d: SparkLine(price: [0])
    )
    
    @State private var favoriteList = UserDefaultsManager.favorite
    
    var id: String

    
    var body: some View {
        VStack(alignment: .leading) {
            MarketHeaderView(coinMarket: coinMarket)
            MarketPriceGrid(coinMarket: coinMarket)
            GraphView(prices: coinMarket.sparkLine7d.price)
            updateDateText()
        }
        .navigationBarTitleDisplayMode(.inline)
        .asNavigationBarItem {
            EmptyView()
        } trailing: {
            Button(action: {
                if let _ = favoriteList[id] {
                    favoriteList[id] = nil
                } else {
                    if favoriteList.count < 10 {
                        favoriteList[id] = id
                    }
                }
            }, label: {
                if let _ = favoriteList[id] {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.purple)
                } else {
                    Image(systemName: "star")
                        .foregroundStyle(.purple)
                }
            
            })
        }
        .task {
            CoingeckoService.callRequest(
                endPoint: APIURL.market(ids: id).endPoint,
                response: [CoinMarket].self) { result in
                    switch result {
                    case .success(let value):
                        if let item = value.first {
                            coinMarket = item
                        }
                        print(value)
                    case .failure(let error):
                        print(error)
                    }
                }
        }
    }
    
    func updateDateText() -> some View {
        Text(coinMarket.updateDescription)
            .foregroundStyle(.gray)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 4)
    }
    
}

struct MarketHeaderView: View {
    let coinMarket: CoinMarket
    
    init(coinMarket: CoinMarket) {
        self.coinMarket = coinMarket
    }
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    CoinIconView(urlString: coinMarket.image)
                    Text(coinMarket.name)
                        .font(.title.bold())
                }
                VStack(alignment: .leading) {
                    Text(coinMarket.priceDescription)
                        .font(.title.bold())
                    HStack {
                        Text(coinMarket.percentDescription)
                            .font(.callout)
                            .asSignColorText(String(coinMarket.percentDescription.prefix(1)))
                        Text("Today")
                            .font(.callout)
                            .foregroundStyle(.gray)
                    }
                }
            }
            Spacer()
        }
        .padding()
        
    }
}

struct MarketPriceView: View {
    enum PriceType: String {
        case high = "고가"
        case highest = "신고점"
        case low = "저가"
        case lowest = "신저점"
        
        var color: Color {
            switch self {
            case .high, .highest:
                    return .red
            case .low, .lowest:
                return .blue
            }
        }
    }
    
    let type: PriceType
    let price: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(type.rawValue)
                .bold()
                .foregroundStyle(type.color).bold()
            Text(price)
                .font(.callout)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
}

struct MarketPriceGrid: View {
    let coinMarket: CoinMarket
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            MarketPriceView(type: .high, price: coinMarket.highPriceDescription)
            MarketPriceView(type: .low, price: coinMarket.lowPriceDescription)
            MarketPriceView(type: .highest, price: coinMarket.athDescription)
            MarketPriceView(type: .lowest, price: coinMarket.atlDescription)
        }
    }
}

struct GraphView: View {
    let prices: [Double]
    
    var body: some View {
        let curColor = Color(.purple)
        let curGradient = LinearGradient(
            gradient: Gradient (
                colors: [
                    curColor.opacity(0.5),
                    curColor.opacity(0.3),
                    curColor.opacity(0.1)
                ]
            ),
            startPoint: .top, endPoint: .bottom)
        
        Chart {
            ForEach(0..<prices.count, id: \.self) { item in
                LineMark(
                    x: .value("", item),
                    y: .value("", prices[item])
                )
                .foregroundStyle(curColor)
                .interpolationMethod(.catmullRom)
                
                AreaMark(x: .value("", item),
                         y: .value("", prices[item]))
                .foregroundStyle(curGradient)
                .interpolationMethod(.catmullRom)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .padding(.vertical, 2)
    }
}

