//
//  CustomNavBarModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/4/24.
//

import SwiftUI

/// 커스텀 네비게이션 컨테이너를 생성하는 구현체 입니다.
struct NavBarModifier<C, L, R>: ViewModifier where C: View, L: View, R: View {
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
                HStack(spacing: 0) {
                    left?()                        
                    Spacer()
                    right?()
                }
                .padding(.horizontal, 28)
                .frame(maxWidth: .infinity)
                
                HStack {
                    Spacer()
                    center?()
                    Spacer()
                }
            }
            .frame(height: 52)            
            
            Spacer()
            
            content
            
            Spacer()
        }
        .background(.bgcolor)
        .navigationBarHidden(true)
    }
}

extension View {
    func customNavigation<C, L, R> (
        center: @escaping (() -> C),
        left: @escaping (() -> L),
        right: @escaping (() -> R)
    ) -> some View where C: View, L: View, R: View {
        modifier(NavBarModifier(center: center, left: left, right: right))
    }
    
    func customNavigation<C, R> (
        center: @escaping (() -> C),
        right: @escaping (() -> R)
    ) -> some View where C: View, R: View {
        modifier(NavBarModifier(center: center, right: right))
    }

    func customNavigation<C, L> (
        center: @escaping (() -> C),
        left: @escaping (() -> L)
    ) -> some View where C: View, L: View {
        modifier(NavBarModifier(center: center, left: left))
    }
    
    func customNavigation<C> (
        center: @escaping (() -> C)
    ) -> some View where C: View {
        modifier(NavBarModifier(center: center))
    }
    
    func customNavigation<L> (
        left: @escaping (() -> L)
    ) -> some View where L: View {
        modifier(NavBarModifier(left: left))
    }
    
    func customNavigation<R> (
        right: @escaping (() -> R)
    ) -> some View where R: View {
        modifier(NavBarModifier(right: right))
    }
    
    func customNavigation<L, R> (
        left: @escaping (() -> L),
        right: @escaping (() -> R)
    ) -> some View where L: View, R: View{
        modifier(NavBarModifier(left: left, right: right))
    }
}
