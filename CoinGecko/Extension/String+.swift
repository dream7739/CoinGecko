//
//  String+.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import Foundation

//iOS15 + >> NSAttributedString -> AttributedString
extension String {
    func toAttributedString(_ keyword: String) -> AttributedString {
        var attributedString = AttributedString(self)
        attributedString.font = .body.bold()
        attributedString.foregroundColor = .black
        
        if let range = attributedString.range(of: keyword, options: .caseInsensitive) {
            attributedString[range].foregroundColor = .purple
            attributedString[range].font = .body.bold()
        }
        
        return attributedString
    }
    
    func dateFormatString() -> String {
        let date = DateFormatManager.serverDateFormatter.date(from: self) ?? Date()
        let dateString = DateFormatManager.basicDateFormatter.string(from: date)
        return dateString
    }
}
