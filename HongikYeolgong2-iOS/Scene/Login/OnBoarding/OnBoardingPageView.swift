//
//  OnBoardingPageView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/21/24.
//

import SwiftUI

struct OnBoardingPageView: View {
    let imageName: String
    let title: String
    let subTitle: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack {
                Image(imageName)
            }
            .frame(height: UIScreen.UIHeight(124))
            .padding(.bottom, UIScreen.UIHeight(74))
            
            CustomText(font: .suite, title: title, textColor: .white, textWeight: .bold, textSize: 21, textAlignment: .center)
                .padding(.bottom, UIScreen.UIHeight(13))
                .opacity(0.9)
            
            CustomText(font: .suite, title: subTitle, textColor: .customGray200, textWeight: .medium, textSize: 15, textAlignment: .center)
                .lineSpacing(3)
                .opacity(0.6)
        }
    }
}

#Preview {
    OnBoardingPageView(imageName: "", title: "", subTitle: "")
}

