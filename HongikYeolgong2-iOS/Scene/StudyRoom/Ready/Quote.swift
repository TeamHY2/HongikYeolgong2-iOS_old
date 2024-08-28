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
            
            Spacer().frame(height: 16)
                    
            Text(wiseSaying.quote)
                .font(.pretendard(size: 18, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray100)
            
            Spacer().frame(height: 12)
            
            Text(wiseSaying.author)
                .font(.pretendard(size: 12, weight: .regular))
                .multilineTextAlignment(.center)
                .foregroundColor(.gray200)
            
            Spacer()
        }
        .frame(height: 150)        
    }
}

//#Preview {
//    Quote()
//}
