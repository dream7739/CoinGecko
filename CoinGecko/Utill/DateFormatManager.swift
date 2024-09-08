//
//  DateFormatManager.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/8/24.
//

import Foundation

enum DateFormatManager {
    private enum DateFormat: String {
        case mdhhmmss = "M/d hh:mm:ss"
    }
    
    static let serverDateFormatter = {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter
    }()
    
    static let basicDateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.mdhhmmss.rawValue
        return dateFormatter
    }()
}
