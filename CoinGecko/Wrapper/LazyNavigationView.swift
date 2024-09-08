//
//  LazyNavigationView.swift
//  CoinGecko
//
//  Created by 홍정민 on 9/7/24.
//

import SwiftUI

//NavigationLink의 destination으로 지정된 뷰는 미리 로드됨
//많은 기능을 가진 뷰일 수록 성능상 좋지 않아짐
//LazyNavigationView로 한번 래핑해서 바디가 그려질 때 사용
//이게 가능한 이유 -> init이 된다고 body가 그려지지 않음

struct LazyNavigationView<Content: View> : View {
    let closure: () -> Content
    
    init(_ closure: @autoclosure @escaping () -> Content) {
        self.closure = closure
        //escaping으로만 사용하면 LazyNavigationView { JeongminView() }
        //autoclosure를 함께 사용하면 LazyNavigationView(JeongminView())
    }
    
    var body: some View {
        closure()
    }
}

