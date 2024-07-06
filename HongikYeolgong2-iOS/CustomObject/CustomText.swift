

import SwiftUI

enum fontOption: String {
    case pretendard = "Pretendard"
    case suite = "SUITE"
}

struct CustomText: View {
    
    let font: fontOption
    let title: String
    let textColor: UIColor
    let textWeight: Font.Weight
    let textSize: CGFloat
    
    init(font: fontOption, title: String, textColor: UIColor, textWeight: Font.Weight, textSize: CGFloat) {
        self.font = font
        self.title = title
        self.textColor = textColor
        self.textWeight = textWeight
        self.textSize = textSize
    }
    
    var body: some View {
        Text(title)
            .font(.custom(font.rawValue, fixedSize: textSize))            
            .fontWeight(textWeight)
            .foregroundStyle(Color(textColor))
            .minimumScaleFactor(0.2)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
    }
}
