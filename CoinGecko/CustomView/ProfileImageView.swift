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
            .frame(width: 44, height: 44)
            .asRoundCornerBorder(color: .purple)
    }
}

#Preview {
    ProfileImageView()
}
