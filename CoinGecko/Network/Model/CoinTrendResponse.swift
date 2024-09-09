//
//  CoinTrendResponse.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import Foundation

struct CoinTrendResponse: Decodable, Hashable {
    let coins: [CoinTrend]
    let nfts: [NFTTrend]
}

struct CoinTrend: Decodable, Hashable {
    let item: CoinTrendItem
}


struct CoinTrendItem: Decodable, Hashable {
    let id: String
    let name: String
    let symbol: String
    let small: String
    let data: CoinData
}

struct CoinData: Decodable, Hashable {
    let price: Double //코인 가격
    let priceChangePercentage: CoinPercentage // //코인 변동폭
    
    enum CodingKeys: String, CodingKey {
        case price
        case priceChangePercentage = "price_change_percentage_24h"
    }
    
    var priceDescription: String {
        return "$" + String(format: "%.4f", price)
    }
}

struct CoinPercentage: Decodable, Hashable {
    let krw: Double
    
    var krwPercentDescription: String {
        let sign = krw > 0 ? "+" : ""
        return sign + String(format: "%.2f", krw) + "%"
    }
}

struct NFTTrend: Decodable, Hashable {
    let name: String
    let symbol: String
    let thumb: String
    let data: NFTData
}

struct NFTData: Decodable, Hashable {
    let floorPrice: String //NFT 최저가
    let priceChangePercentage: String //변동폭 (소숫점 2째)
    
    enum CodingKeys: String, CodingKey {
        case floorPrice = "floor_price"
        case priceChangePercentage = "floor_price_in_usd_24h_percentage_change"
    }
    
    var pricePercentDescription: String {
        if let numberPercent = Double(priceChangePercentage) {
            let sign = numberPercent > 0 ? "+" : ""
            return sign + String(format: "%.2f", numberPercent) + "%"
        } else {
            return "+0.00%"
        }
    }
}
