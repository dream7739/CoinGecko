//
//  CoinSearchResponse.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import Foundation

struct CoinSearchResponse: Decodable {
    let coins: [CoinSearch]
}

struct CoinSearch: Decodable, Hashable, Identifiable {
    let id: String
    let name: String
    let apiSymbol: String
    let symbol: String
    let marketCapRank: Int?
    let thumb: String
    let large: String
    var isLike = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case apiSymbol = "api_symbol"
        case symbol
        case marketCapRank = "market_cap_rank"
        case thumb
        case large
    }
}
