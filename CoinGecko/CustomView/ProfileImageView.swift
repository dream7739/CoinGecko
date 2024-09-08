//
//  ProfileImageView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Image(.bear)
            .resizable()
            .frame(width: 38, height: 38)
            .asRoundCornerBorder(color: .purple)
    }
}

#Preview {
    ProfileImageView()
}
