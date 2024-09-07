//
//  CoingeckoService.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import Foundation

struct CoingeckoService {
    private init() { }
    
    static func callSearchRequest(query: String, completion: @escaping (CoinSearchResponse) -> Void) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/search?query=\(query)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    return
                }
                
                guard let response = response else {
                    return
                }
                
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(CoinSearchResponse.self, from: data)
                        completion(decodedData)
                    } catch {
                        print(error)
                    }
                } else {
                    return
                }
                
            }
        }.resume()
    }
}
