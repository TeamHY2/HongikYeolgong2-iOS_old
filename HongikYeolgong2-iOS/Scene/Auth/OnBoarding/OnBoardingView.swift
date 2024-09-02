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
                OnBoardingPageView(imageName: "onboarding01")
                    .tag(0)
                OnBoardingPageView(imageName: "onboarding02")
                    .tag(1)
                OnBoardingPageView(imageName: "onboarding03")
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
