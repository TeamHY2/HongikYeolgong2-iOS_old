//
//  View+.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/4/24.
//

import SwiftUI

extension View {
    /// 이 메서드는 지정된 뷰를 포함하는 커스텀 네비게이션 컨테이너를 반환합니다. 네비게이션 바의 타이틀과 백 버튼의 동작 등을 설정할 수 있습니다.
    /// - Parameters:
    ///   - center: 중앙에 표시될 뷰입니다.
    ///   - left: 좌측에 표시될 뷰입니다.
    ///   - right: 우측에 표시될 뷰입니다.
    /// - Returns: 커스텀 네비게이션을 포함하는 뷰를 반환합니다.
    func customNavigation<C, L, R> (
        center: @escaping (() -> C),
        left: @escaping (() -> L),
        right: @escaping (() -> R)
    ) -> some View where C: View, L: View, R: View {
        modifier(CustomNavBarModifier(center: center, left: left, right: right))
    }
    
    /// 이 메서드는 지정된 뷰를 포함하는 커스텀 네비게이션 컨테이너를 반환합니다. 네비게이션 바의 타이틀과 백 버튼의 동작 등을 설정할 수 있습니다.
    /// - Parameters:
    ///   - center: 중앙에 표시될 뷰입니다.
    ///   - right: 우측에 표시될 뷰입니다.
    /// - Returns: 커스텀 네비게이션을 포함하는 뷰를 반환합니다.
    func customNavigation<C, R> (
        center: @escaping (() -> C),
        right: @escaping (() -> R)
    ) -> some View where C: View, R: View {
        modifier(CustomNavBarModifier(center: center, right: right))
    }
    
    /// 이 메서드는 지정된 뷰를 포함하는 커스텀 네비게이션 컨테이너를 반환합니다. 네비게이션 바의 타이틀과 백 버튼의 동작 등을 설정할 수 있습니다.
    /// - Parameters:
    ///   - center: 중앙에 표시될 뷰입니다.
    ///   - left: 좌측에 표시될 뷰입니다.s
    /// - Returns: 커스텀 네비게이션을 포함하는 뷰를 반환합니다.
    func customNavigation<C, L> (
        center: @escaping (() -> C),
        left: @escaping (() -> L)
    ) -> some View where C: View, L: View {
        modifier(CustomNavBarModifier(center: center, left: left))
    }
    
    /// 이 메서드는 지정된 뷰를 포함하는 커스텀 네비게이션 컨테이너를 반환합니다. 네비게이션 바의 타이틀과 백 버튼의 동작 등을 설정할 수 있습니다.
    /// - Parameters:
    ///   - center: 중앙에 표시될 뷰입니다.
    /// - Returns: 커스텀 네비게이션을 포함하는 뷰를 반환합니다.
    func customNavigation<C> (
        center: @escaping (() -> C)
    ) -> some View where C: View {
        modifier(CustomNavBarModifier(center: center))
    }
    
    /// 이 메서드는 지정된 뷰를 포함하는 커스텀 네비게이션 컨테이너를 반환합니다. 네비게이션 바의 타이틀과 백 버튼의 동작 등을 설정할 수 있습니다.
    /// - Parameters:
    ///   - left: 좌측에 표시될 뷰입니다.
    /// - Returns: 커스텀 네비게이션을 포함하는 뷰를 반환합니다.
    func customNavigation<L> (
        left: @escaping (() -> L)
    ) -> some View where L: View {
        modifier(CustomNavBarModifier(left: left))
    }
    
    /// 이 메서드는 지정된 뷰를 포함하는 커스텀 네비게이션 컨테이너를 반환합니다. 네비게이션 바의 타이틀과 백 버튼의 동작 등을 설정할 수 있습니다.
    /// - Parameters:
    ///   - right: 우측에 표시될 뷰입니다.
    /// - Returns: 커스텀 네비게이션을 포함하는 뷰를 반환합니다.
    func customNavigation<R> (
        right: @escaping (() -> R)
    ) -> some View where R: View {
        modifier(CustomNavBarModifier(right: right))
    }
    
    /// 이 메서드는 지정된 뷰를 포함하는 커스텀 네비게이션 컨테이너를 반환합니다. 네비게이션 바의 타이틀과 백 버튼의 동작 등을 설정할 수 있습니다.
    /// - Parameters:
    ///   - left: 좌측에 표시될 뷰입니다.
    ///   - right: 우측에 표시될 뷰입니다.
    /// - Returns: 커스텀 네비게이션을 포함하는 뷰를 반환합니다.
    func customNavigation<L, R> (
        left: @escaping (() -> L),
        right: @escaping (() -> R)
    ) -> some View where L: View, R: View{
        modifier(CustomNavBarModifier(left: left, right: right))
    }
}

extension View {
    /// bool값에 따라 뷰의 숨김상태를 조정합니다.
    /// - Parameter hidden: 숨김상태를 설정하는 bool 변수 입니다.
    /// - Returns: 숨김 상태가 적용된 뷰를 반환합니다.
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
            if hidden {
                self.hidden()
            } else {
                self
            }
        }
}

extension View {
    /// 커스텀 다이얼로그를 반환합니다.
    /// - Parameters:
    ///   - isPresented: 숨김 상태에 대한 변수입니다.
    ///   - confirmAction: 확인 버튼을 터치 했을때 호출되는 클로저 입니다.
    ///   - cancelAction: 취소 버튼을 터치 했을때 호출되는 클로저 입니다.
    func dialog(isPresented: Binding<Bool>, currentDate: Binding<Date>, confirmAction: @escaping () -> (), cancelAction: @escaping () -> ()) -> some View {
        modifier(DialogModifier(isPresented: isPresented, currentDate: currentDate, confirmAction: confirmAction, cancelAction: cancelAction))
    }
    
    func dialog(isPresented: Binding<Bool>, currentDate: Binding<Date>, confirmAction: @escaping () -> ()) -> some View {
        modifier(DialogModifier(isPresented: isPresented, currentDate: currentDate, confirmAction: confirmAction))
    }
}

extension View {
    func alert(title: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?, cancelAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, confirmAction: confirmAction, cancleAction: cancelAction, isPresented: isPresented))
    }
    
    func alert(title: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, confirmAction: confirmAction, isPresented: isPresented))
    }
    
    func alert(title: String, confirmButtonText: String, cancleButtonText: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?, cancelAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, confirmButtonText: confirmButtonText, cancleButtonText: cancleButtonText, confirmAction: confirmAction, cancleAction: cancelAction, isPresented: isPresented))
    }
    
    func alert(title: String, confirmButtonText: String, cancleButtonText: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, confirmButtonText: confirmButtonText, cancleButtonText: cancleButtonText, confirmAction: confirmAction, isPresented: isPresented))
    }
}
