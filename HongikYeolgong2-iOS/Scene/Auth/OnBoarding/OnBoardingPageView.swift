//
//  OnBoardingPageView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/21/24.
//

import SwiftUI

struct OnBoardingPageView: View {
    let imageName: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image(imageName)                
        }        
    }
}

#Preview {
    OnBoardingPageView(imageName: "")
}

