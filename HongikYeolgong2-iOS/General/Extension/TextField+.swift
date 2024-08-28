//
//  TextField+.swift
//  HongikYeolgong2-iOS
//
//  Created by 변정훈 on 8/28/24.
//

import Foundation
import SwiftUI

extension TextField {
    func addLeftPadding(_ width: CGFloat) -> some View {
        return self.padding(.leading, width)
    }
}
