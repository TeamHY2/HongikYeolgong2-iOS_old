
import Foundation
import UIKit

extension UIScreen {
    static func UIWidth(_ iPhoneProMaxWidth: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.width * (iPhoneProMaxWidth/375)
    }
    
    static func UIHeight(_ iPhoneProMaxHeight: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.size.height * (iPhoneProMaxHeight/812)
    }    
}

extension Double {
    var adjusted: CGFloat {
        let ratio = UIScreen.main.bounds.size.width * (self/375)
        return ratio
    }
    
    var adjustedH: CGFloat {
        let ratio = UIScreen.main.bounds.size.height * (self/812)
        return ratio
    }
}
