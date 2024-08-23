//
//  OnBoardingView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/21/24.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var seletedIndex = 0
    
    var body: some View {
        VStack {
            Spacer()
            // OnBoardingPage
            TabView(selection: $seletedIndex) {
                
                OnBoardingPageView(imageName: "speech_bubble", title: "이런 경험, 한 적 있나요?", subTitle: "열람실 연장 시간을 놓치면 \n 종종 이런 머쓱한 경험을 하게 돼요.")
                    .tag(0)
                OnBoardingPageView(imageName: "bell", title: "열공이로 자리를 사수해요!", subTitle: "잊지 않고 열람실 연장을 할 수 있도록 \n 다양한 방법으로 알림을 줄게요.")
                    .tag(1)
                OnBoardingPageView(imageName: "calendar", title: "나의 열람실 이용량은?", subTitle: "홍익열공이로 공부하고, \n 빛으로 반짝이는 캘린더로 만들어보세요!")
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer()
            
            // Indicator
            HStack(spacing: 16) {
                ForEach(0...2, id: \.self) { index in
                    Group {
                        if index == seletedIndex {
                            Image(.shineCount02)
                                .frame(width: 9, height: 9)
                        } else {
                            Circle()
                                .frame(width: 9, height: 9)
                                .foregroundColor(Color(.customGray600))
                        }
                    }.onTapGesture {
                        seletedIndex = index
                    }
                }
            }
        }
    }
}

#Preview {
    OnBoardingView()
}
