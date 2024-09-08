//
//  URLSession+.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import Foundation

extension URLSession {
    typealias completion = (Data?, URLResponse?, Error?) -> Void
    
    func dataTaskResume(_ request: URLRequest, completion: @escaping completion) {
        dataTask(with: request, completionHandler: completion).resume()
    }
}
