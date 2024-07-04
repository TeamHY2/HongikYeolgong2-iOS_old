
import Foundation
import UIKit

extension UIScreen {
    
    static func UIWidth(_ iPhoneProMaxWidth: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.width * (iPhoneProMaxWidth/430)
    }
    
    static func UIHeight(_ iPhoneProMaxHeight: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * (iPhoneProMaxHeight/932)
    }
    
}
