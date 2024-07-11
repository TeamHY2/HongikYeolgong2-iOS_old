
import SwiftUI



struct CustomButton: View {
    
    let font: fontOption
    let action: () -> Void
    let title: String
    let titleColor: UIColor
    let backgroundColor: UIColor
    let leading: CGFloat
    let trailing: CGFloat
    let width: CGFloat
    let height: CGFloat
    
    init(action: @escaping () -> Void,font: fontOption, title: String, titleColor: UIColor, backgroundColor: UIColor, leading: CGFloat, trailing: CGFloat, width: CGFloat = 312, height: CGFloat = 44) {
        self.font = font
        self.action = action
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.leading = leading
        self.trailing = trailing
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Button(action: action, label: {
            Spacer()
            CustomText(font: font, title: title, textColor: titleColor, textWeight: .medium, textSize: 16)
                .frame(maxWidth: UIScreen.UIWidth(width), minHeight: UIScreen.UIHeight(height))
            Spacer()
        })        
        .background(Color(backgroundColor))
        .cornerRadius(4)
        .padding(.leading, UIScreen.UIWidth(leading))
        .padding(.trailing, UIScreen.UIWidth(trailing))
    }
}

#Preview {
    CustomButton(action: {}, font:.pretendard, title: "123", titleColor: UIColor.white, backgroundColor: UIColor.black, leading: 24, trailing: 24)
}
