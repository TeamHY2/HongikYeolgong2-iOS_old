//
//  DialogModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/10/24.
//

import SwiftUI
import Combine


struct DialogModifier: ViewModifier {
    
    private let hours = Array(repeating: Array(1...12), count: 100).flatMap { $0 }
    private let minutes = Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    private let dayParts = ["AM", "PM"]
    
    private var cancelablles = Set<AnyCancellable>()
    
    @State private var selectedHour = CurrentValueSubject<Int, Never>(0)
    @State private var selectedMinute = CurrentValueSubject<Int, Never>(0)
    @State private var daypart = CurrentValueSubject<String, Never>("AM")
    
    @Binding var isPresented: Bool
    @Binding var currentDate: Date
    
    let confirmAction: (() -> ())?
    let cancleAction: (() -> ())?
    
    init(isPresented: Binding<Bool>, currentDate: Binding<Date>, confirmAction: @escaping () -> (), cancelAction: @escaping () -> ()) {
        self._isPresented = isPresented
        self._currentDate = currentDate
        self.confirmAction = confirmAction
        self.cancleAction = cancelAction
    }
    
    func body(content: Content) -> some View {
        content
            .overlay (
                ZStack {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        Spacer().frame(height: UIScreen.UIHeight(40))
                        
                        // title
                        CustomText(font: .pretendard, title: "열람실 이용 시작 시간", textColor: .customGray100, textWeight: .semibold, textSize: 18)
                        
                        Spacer().frame(height: UIScreen.UIHeight(30))
                        
                        // picker
                            HStack {
                                CustomPicker(selected: $selectedHour.value, data: hours)
                                    
                                CustomText(font: .suite, title: ":", textColor: .white, textWeight: .bold, textSize: 24)
                                
                                CustomPicker(selected: $selectedMinute.value, data: minutes)
                                
                                CustomPicker(selected: $daypart.value, data: dayParts)
                            }
                            .frame(height: UIScreen.UIHeight(131))
                            .frame(width: UIScreen.UIWidth(166))
                            .padding(.horizontal, UIScreen.UIWidth(50))
                            .mask(
                                LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: Color(.customGray800).opacity(0), location: 0),
                                            .init(color: Color(.customGray800), location: 0.33)
                                        ]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                )
                            )
                            .mask(
                                LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: Color(.customGray800).opacity(0), location: 0),
                                            .init(color: Color(.customGray800), location: 0.33)
                                        ]),
                                        startPoint: .bottom,
                                        endPoint: .top
                                )
                            )
                        
                        
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
                }
                    .isHidden(!isPresented)
                    .onAppear {
                        setCurrentDate()
                    }
                    .onReceive(Publishers.CombineLatest3(selectedHour, selectedMinute, daypart), perform: {
                        currentDate = createDate($0.0, $0.1, $0.2) ?? Date()
                    })
                
            )
    }
    
    private func setCurrentDate() {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: currentDate)
        let minutes = calendar.component(.minute, from: currentDate)
        let hour12 = hour % 12 == 0 ? 12 : hour % 12
        let period = hour < 12 ? "AM" : "PM"
        
        selectedHour.send(hour12)
        selectedMinute.send(minutes)
        daypart.send(period)
    }
    
    
    func createDate(_ hour: Int, _ minute: Int, _ period: String) -> Date? {
        var adjustedHour = hour
        
        if period.uppercased() == "PM" && hour != 12 {
            adjustedHour += 12
        }
        
        if period.uppercased() == "AM" && hour == 12 {
            adjustedHour = 0
        }
        
        let now = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)
        let day = calendar.component(.day, from: now)
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = adjustedHour
        dateComponents.minute = minute
        
        return calendar.date(from: dateComponents)
    }
}


