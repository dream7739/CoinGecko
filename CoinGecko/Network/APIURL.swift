//
//  APIURL.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import Foundation

enum APIURL {
    static let baseURL: String = "https://api.coingecko.com/api/v3/"
    
    case search(query: String)
    
    var endPoint: String {
        switch self {
        case .search(let query):
            return APIURL.baseURL + "search?query=\(query)"
        }
    }
}
