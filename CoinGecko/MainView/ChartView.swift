//
//  ChartView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State var coinMarket = marketDummy
    
    var body: some View {
        VStack(alignment: .leading) {
            MarketHeaderView(coinMarket: coinMarket.first!)
            MarketPriceGrid(coinMarket: coinMarket.first!)
            GraphView(prices: coinMarket.first!.sparkLine7d.price)
            updateDateText()
        }
        .navigationBarTitleDisplayMode(.inline)
        .asNavigationBarItem {
            EmptyView()
        } trailing: {
            Image(systemName: "star")
                .foregroundColor(.purple)
        }
    }
    
    func updateDateText() -> some View {
        Text(coinMarket.first!.updateDescription)
            .foregroundStyle(.gray)
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
                    //                    Image(systemName: "star")
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
                            .foregroundStyle(.red)
                        Text("Today")
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
    let title: String
    let price: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .foregroundStyle(.red).bold()
            Text(price)
                .font(.callout)
                .foregroundStyle(.gray)
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
            MarketPriceView(title: "고가", price: coinMarket.highPriceDescription)
            MarketPriceView(title: "신고점", price: coinMarket.athDescription)
            MarketPriceView(title: "저가", price: coinMarket.lowPriceDescription)
            MarketPriceView(title: "신저점", price: coinMarket.atlDescription)
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
                    curColor.opacity(0.7),
                    curColor.opacity(0.5),
                    curColor.opacity(0.3)
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
        .padding(.vertical, 4)
    }
}

#Preview {
    ChartView()
}
