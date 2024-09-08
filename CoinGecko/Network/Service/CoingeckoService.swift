//
//  CoingeckoService.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import Foundation


struct CoingeckoService {
    private init() { }
    
    static func callRequest<T: Decodable>(
        endPoint: String,
        response: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: endPoint) else { return }
        
        URLSession.shared.dataTaskResume(URLRequest(url: url)) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    completion(.failure(.errorOccured))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(.noResponse))
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(.failure(.invalidStatus))
                    return
                }
                
                guard let data = data else {
                    return completion(.failure(APIError.noData))
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decoding))
                }
                
            }
        }
    }
}
