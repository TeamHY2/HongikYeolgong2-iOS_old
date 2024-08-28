//
//  CustomButton.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import SwiftUI

struct CustomButton: View {
    
    enum ButtonStyle {
        case rounded
        case rectangle
        case background(image: ImageResource)
    }
    
    let title: String
    let action: () -> ()
    let style: ButtonStyle
    
    init(title: String, style: ButtonStyle, action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.style = style
    }
    
    var body: some View {
        switch style {
        case .rounded:
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.pretendard(size: 16, weight: .regular))
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .foregroundColor(.white)
            })
            .background(.blue100)
            .cornerRadius(8)
        case .rectangle:
            EmptyView()
        case .background(let image):
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.suite(size: 16, weight: .semibold))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(.white)
            })
            .background(
                Image(image)
                    .resizable()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.blue400, lineWidth: 1)
                    )
            )
            .cornerRadius(8)
        }
    }
}

//#Preview {
//    CustomButton()
//}
