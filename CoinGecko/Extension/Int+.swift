//
//  Int+.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import Foundation

extension Int {
    var toFormattedString: String {
        return "₩" + self.formatted()
    }
}
