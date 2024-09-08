//
//  APIError.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import Foundation

enum APIError: Error {
    case errorOccured
    case noData
    case noResponse
    case invalidStatus
    case decoding
}
