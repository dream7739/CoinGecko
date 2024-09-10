//
//  APIURL.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import Foundation

//https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&ids=bitcoin&sparkline=true


enum APIURL {
    static let baseURL: String = "https://api.coingecko.com/api/v3/"
    
    case search(query: String)
    case trending
    case market(ids: String)
    
    var endPoint: String {
        switch self {
        case .search(let query):
            return APIURL.baseURL + "search?query=\(query)"
        case .trending:
            return APIURL.baseURL + "search/trending"
        case .market(let ids):
            return APIURL.baseURL + "coins/markets?vs_currency=krw&ids=\(ids)&sparkline=true"
        }
    }
}
