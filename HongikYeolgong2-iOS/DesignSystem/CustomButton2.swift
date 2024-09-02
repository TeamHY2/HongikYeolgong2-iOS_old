//
//  CustomButton2.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/8/24.
//

import SwiftUI

struct CustomButton2: View {
    let action: (() -> ())
    let title: String
    let image: ImageResource
    let maxWidth: CGFloat
    let minHeight: CGFloat
    
    var body: some View {
        Button(action: action, label: {            
            Text(title)
                .font(.suite(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: UIScreen.UIWidth(maxWidth), minHeight: UIScreen.UIHeight(minHeight))
        })
        .background(
            Image(image)
                .resizable()
                .frame(maxWidth: UIScreen.UIWidth(maxWidth), minHeight: UIScreen.UIHeight(minHeight))
                .cornerRadius(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.customBlue400), lineWidth: 1)
                )
        )
    }
}

//#Preview {
//    CustomButton2()
//}
