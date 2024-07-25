//
//  AlertModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/10/24.
//

import SwiftUI
import Combine
struct AlertModifier: ViewModifier {
    
    var confirmButtonText: String = "네"
    var cancleButtonText: String = "아니오"
    
    let title: String
    let confirmAction: (() -> ())?
    let cancleAction: (() -> ())?
    
    @State private var scale: CGFloat = 1
    
    @Binding var isPresented: Bool
    
    init(title: String, confirmButtonText: String, cancleButtonText: String, confirmAction: (() -> Void)?, cancleAction: (() -> Void)? = nil, isPresented: Binding<Bool>) {
        self.confirmButtonText = confirmButtonText
        self.cancleButtonText = cancleButtonText
        self.title = title
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
        self._isPresented = isPresented
    }
    
    init(title: String, confirmAction: (() -> Void)?, cancleAction: (() -> Void)? = nil, isPresented: Binding<Bool>) {
        self.title = title
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
        self._isPresented = isPresented
    }
    
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        Spacer().frame(height: UIScreen.UIHeight(40))
                        
                        // title
                        CustomText(font: .pretendard, title: title, textColor: .customGray100, textWeight: .semibold, textSize: 18)
                        
                        Spacer().frame(height: UIScreen.UIHeight(30))
                        
                        HStack {
                            Button(action: {
                                cancleAction?()
                                isPresented = false
                            }) {
                                CustomText(font: .pretendard, title: cancleButtonText, textColor: .customGray200, textWeight: .semibold, textSize: 16)
                                    .frame(maxWidth: .infinity, minHeight: 46)
                            }
                            .background(Color(.customGray600))
                            .cornerRadius(8)
                            
                            Spacer().frame(width: UIScreen.UIWidth(12))
                            
                            Button(action: {
                                confirmAction?()
                                isPresented = false
                            }) {
                                CustomText(font: .pretendard, title: confirmButtonText, textColor: .white, textWeight: .semibold, textSize: 16)
                                    .frame(maxWidth: .infinity, minHeight: 46)
                            }
                            .background(Color(.customBlue100))
                            .cornerRadius(8)
                            
                        }
                        .padding(.horizontal, UIScreen.UIWidth(24))
                        
                        Spacer().frame(height: UIScreen.UIHeight(30))
                    }
                    .frame(maxWidth: UIScreen.UIWidth(316))
                    .background(Color(.customGray800))
                    .cornerRadius(8)
                    .scaleEffect(scale)
                    .animation(.interpolatingSpring(mass: 1.0, stiffness: 200, damping: 15), value: scale)
                    }
                    
                    .onReceive(Just(isPresented), perform: { newValue in
                        if newValue {
                            scale = 1.0
                        } else {
                            scale = 0.9
                        }
                    })
                   
                .isHidden(!isPresented)
            )
    }
}
