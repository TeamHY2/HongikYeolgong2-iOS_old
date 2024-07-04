//
//  CustomNavBarModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/4/24.
//

import SwiftUI

/// 커스텀 네비게이션 컨테이너를 생성하는 구현체 입니다.
struct CustomNavBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
    let center: (() ->C)?
    let left: (() -> L)?
    let right: (() -> R)?
    
    init(center: (() -> C)? = {EmptyView()}, left: (()-> L)? = {EmptyView()}, right: (()-> R)? = {EmptyView()}) {
        self.center = center
        self.left = left
        self.right = right
    }
    
    func body(content: Content) -> some View {
        VStack {
            ZStack {
                HStack {
                    left?()
                    Spacer()
                    right?()
                }
                .frame(height: 52)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                
                HStack {
                    Spacer()
                    center?()
                    Spacer()
                }
            }
            .background(.black)
            .foregroundColor(.white)
            
            Spacer()
            
            content
            
            Spacer()
        }
                
        .navigationBarHidden(true)
    }
}
