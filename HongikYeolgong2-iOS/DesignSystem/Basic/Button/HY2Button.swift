//
//  CustomButton.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import SwiftUI

struct HY2Button: View {
    
    enum ButtonStyle {
        case roundedMedium
        case roundedSmall
        case background(image: ImageResource)
    }
    
    let title: String
    let action: () -> ()
    let style: ButtonStyle
    var backgroundColor: Color = Color.Primary.blue100
    var textColor: Color = .white
    var fontSize: CGFloat = 16
    
    init(title: String, 
         textColor: Color,
         fontSize: CGFloat,
         style: ButtonStyle,
         backgroundColor: Color = Color.Primary.blue100,
         action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.style = style
        self.textColor = textColor
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
    }
    
    init(title: String, 
         style: ButtonStyle,
         backgroundColor: Color = Color.Primary.blue100,
         action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.style = style        
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        switch style {
        case .roundedMedium:
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.pretendard(size: fontSize, weight: .regular))
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .foregroundColor(.white)
            })
            .background(backgroundColor)
            .cornerRadius(8)
        case .roundedSmall:
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.suite(size: fontSize, weight: .semibold))
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .foregroundColor(textColor)
            })
            .background(backgroundColor)
            .cornerRadius(4)
        case .background(let image):
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.suite(size: fontSize, weight: .semibold))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundColor(textColor)
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
