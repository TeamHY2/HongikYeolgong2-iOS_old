//
//  DialogModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/10/24.
//

import SwiftUI

struct DialogModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            
            content
        }
        .background(.red)
    }
}


