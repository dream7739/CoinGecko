//
//  UserDefaultsManager.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/10/24.
//

import Foundation

enum UserDefaultsManager {
    static var favorite: [String: String] {
        get {
            UserDefaults.standard.object(forKey: "favorite") as? [String: String] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "favorite")
        }
    }
}
