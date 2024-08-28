//
//  Quote.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/8/24.
//

import SwiftUI

struct Quote: View {
    let wiseSaying: WiseSaying
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(.shineCount01)
                Image(.shineCount02)
                Image(.shineCount03)
            }
            
            .padding(.bottom, UIScreen.UIHeight(16))
            
            CustomText(font: .pretendard, title: wiseSaying.quote, textColor: .customGray100, textWeight: .regular, textSize: 18, textAlignment: .center)
                .padding(.bottom, UIScreen.UIHeight(12))
                .lineSpacing(3)
                
            CustomText(font: .pretendard, title: wiseSaying.author, textColor: .customGray200, textWeight: .regular, textSize: 12)
        }
    }
}

//#Preview {
//    Quote()
//}
