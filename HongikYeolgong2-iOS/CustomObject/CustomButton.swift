
import SwiftUI



struct CustomButton: View {
    
    let font: fontOption
    let action: () -> Void
    let title: String
    let titleColor: UIColor
    let backgroundColor: UIColor
    let leading: CGFloat
    let trailing: CGFloat
    
    init(action: @escaping () -> Void,font: fontOption, title: String, titleColor: UIColor, backgroundColor: UIColor, leading: CGFloat, trailing: CGFloat) {
        self.font = font
        self.action = action
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.leading = leading
        self.trailing = trailing
    }
    
    var body: some View {
        Button(action: action, label: {
            Spacer()
            CustomText(font: font, title: title, textColor: titleColor, textWeight: .medium, textSize: 16)
                .frame(width: UIScreen.UIWidth(312), height: UIScreen.UIWidth(44))
            Spacer()
        })
        .background(Color(backgroundColor))
        .cornerRadius(4)
        .padding(.leading, leading)
        .padding(.trailing, trailing)
    }
}

#Preview {
    CustomButton(action: {}, font:.pretendard, title: "123", titleColor: UIColor.white, backgroundColor: UIColor.black, leading: 24, trailing: 24)
}
