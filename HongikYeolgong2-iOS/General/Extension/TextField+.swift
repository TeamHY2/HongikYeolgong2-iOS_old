

import Foundation
import SwiftUI

extension TextField {
    func addLeftPadding(_ width: CGFloat) -> some View {
        return self.padding(.leading, width)
    }
}
