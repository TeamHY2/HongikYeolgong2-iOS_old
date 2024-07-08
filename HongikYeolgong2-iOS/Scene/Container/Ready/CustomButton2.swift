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
            CustomText(font: .suite, title: title, textColor: .white, textWeight: .semibold, textSize: 16)
                .frame(maxWidth: UIScreen.UIWidth(maxWidth), minHeight: UIScreen.UIHeight(minHeight))
        })
        .background(
            Image(image)
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
