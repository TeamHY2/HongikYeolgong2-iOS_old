//
//  Quote.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/8/24.
//

import SwiftUI

struct Quote: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(.shineCount01)
                Image(.shineCount02)
                Image(.shineCount03)
            }
            .padding(.bottom, UIScreen.UIHeight(16))
            
            CustomText(font: .pretendard, title: "행동보다 빠르게 불안감을 없앨 수 있는 것은 없습니다.", textColor: .customGray100, textWeight: .regular, textSize: 18, textAlignment: .center)
                .padding(.bottom, UIScreen.UIHeight(12))
                
            CustomText(font: .pretendard, title: "- 윌터 앤더슨", textColor: .customGray200, textWeight: .regular, textSize: 12)
        }
    }
}

#Preview {
    Quote()
}
