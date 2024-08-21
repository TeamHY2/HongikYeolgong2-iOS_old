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
            Image(imageName)
                .padding(.bottom, 73)
            
            CustomText(font: .suite, title: title, textColor: .white, textWeight: .bold, textSize: 21, textAlignment: .center)
                .padding(.bottom, 13)
            
            CustomText(font: .suite, title: subTitle, textColor: .customGray200, textWeight: .medium, textSize: 15, textAlignment: .center)
                .lineSpacing(3)
        }
    }
}

#Preview {
    OnBoardingPageView(imageName: "", title: "", subTitle: "")
}

