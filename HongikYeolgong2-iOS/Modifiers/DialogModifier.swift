//
//  DialogModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/10/24.
//

import SwiftUI

struct DialogModifier: ViewModifier {
    private var hours = Array(1...12)
    private var minutes = Array(0...59)
    private var dayParts = ["AM", "PM"]
    
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var daypart = "AM"
    
    @Binding var isPresented: Bool
    
    let confirmAction: (() -> ())?
    let cancleAction: (() -> ())?
    
    init(isPresented: Binding<Bool>, confirmAction: @escaping () -> (), cancelAction: @escaping () -> ()) {
        self._isPresented = isPresented
        self.confirmAction = confirmAction
        self.cancleAction = cancelAction
    }
    
    func body(content: Content) -> some View {
        content
            .overlay (
                ZStack {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        Spacer().frame(height: UIScreen.UIHeight(40))
                        
                        // title
                        CustomText(font: .pretendard, title: "열람실 이용 시작 시간", textColor: .customGray100, textWeight: .semibold, textSize: 18)
                        
                        Spacer().frame(height: UIScreen.UIHeight(30))
                        
                        // picker
                        HStack {
                            Picker("Hour", selection: $selectedHour) {
                                ForEach(hours, id: \.self) {
                                    CustomText(font: .suite, title: String(format: "%02d", $0), textColor: .white, textWeight: .bold, textSize: 24)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            CustomText(font: .suite, title: ":", textColor: .white, textWeight: .bold, textSize: 24)
                            
                            Picker("Minutes", selection: $selectedMinute) {
                                ForEach(minutes, id: \.self) {
                                    CustomText(font: .suite, title: String(format: "%02d", $0), textColor: .white, textWeight: .bold, textSize: 24)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Picker("", selection: $daypart) {
                                ForEach(dayParts, id: \.self) {
                                    CustomText(font: .suite, title: "\($0)", textColor: .white, textWeight: .bold, textSize: 24)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .frame(height: UIScreen.UIHeight(126))
                        .padding(.horizontal, UIScreen.UIWidth(50))
                        
                        Spacer().frame(height: UIScreen.UIHeight(32))
                        
                        // button
                        HStack {
                            Button(action: {
                                cancleAction?()
                                isPresented = false
                            }) {
                                CustomText(font: .pretendard, title: "취소", textColor: .customGray200, textWeight: .semibold, textSize: 16)
                                    .frame(maxWidth: .infinity, minHeight: 46)
                            }
                            .background(Color(.customGray600))
                            .cornerRadius(8)
                            
                            Spacer().frame(width: UIScreen.UIWidth(12))
                            
                            Button(action: {
                                confirmAction?()
                                isPresented = false
                            }) {
                                CustomText(font: .pretendard, title: "확인", textColor: .white, textWeight: .semibold, textSize: 16)
                                    .frame(maxWidth: .infinity, minHeight: 46)
                            }
                            .background(Color(.customBlue100))
                            .cornerRadius(8)
                            
                        }
                        .padding(.horizontal, UIScreen.UIWidth(24))
                        
                        Spacer().frame(width: UIScreen.UIHeight(30))
                        
                    }
                        .frame(maxWidth: UIScreen.UIWidth(316), maxHeight: UIScreen.UIHeight(336))
                        .background(Color(.customGray800))
                        .cornerRadius(8)
                }.isHidden(!isPresented)                  
            )
           
    }
}


