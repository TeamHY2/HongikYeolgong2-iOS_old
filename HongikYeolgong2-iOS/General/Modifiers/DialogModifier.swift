//
//  DialogModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/10/24.
//

import SwiftUI
import Combine


struct DialogModifier: ViewModifier {
    
    @State private var hours = Array(repeating: Array(1...12), count: 100).flatMap { $0 }
    @State private var minutes = Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    @State private var dayParts = ["AM", "PM"]
    @State private var selectedHour = CurrentValueSubject<Int, Never>(0)
    @State private var selectedMinute = CurrentValueSubject<Int, Never>(0)
    @State private var daypart = CurrentValueSubject<String, Never>("AM")
    @State private var minumumHours = 0
    @State private var minumumMinutes = 0
    @State private var seletedDaypart = "AM"
    
    @Binding var isPresented: Bool
    @Binding var currentDate: Date
    
    private var cancelablles = Set<AnyCancellable>()
    
    let confirmAction: (() -> ())?
    let cancleAction: (() -> ())?
    
    init(isPresented: Binding<Bool>,
         currentDate: Binding<Date>,
         confirmAction: @escaping () -> (),
         cancelAction: (() -> ())? = nil) {
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
                        Spacer().frame(height: 40)
                        
                        // title
                        Text("열람실 이용 시작 시간")
                            .font(.pretendard(size: 18, weight: .semibold))
                            .foregroundStyle(.gray100)
                        
                        Spacer().frame(height: 30)
                        
                        // picker
                        HStack {
                            HY2Picker(data: $hours,
                                      selectedValue: $selectedHour.value,
                                      minimumValue: $minumumHours)
                            
                            Text(":")
                                .font(.suite(size: 24, weight: .bold))
                                .foregroundStyle(.white)
                            
                            HY2Picker(data: $minutes,
                                      selectedValue: $selectedMinute.value,
                                      minimumValue: $minumumMinutes)
                            
                            HY2Picker(data: $dayParts,
                                      selectedValue: $daypart.value,
                                      minimumValue: $seletedDaypart)
                        }
                        .frame(height: 131)
                        .frame(width: 166)
                        .padding(.horizontal, 50)
                        .mask(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.GrayScale.gray800.opacity(0), location: 0),
                                    .init(color: Color.GrayScale.gray800, location: 0.33)
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .mask(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.GrayScale.gray800.opacity(0), location: 0),
                                    .init(color: Color.GrayScale.gray800, location: 0.33)
                                ]),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        
                        
                        Spacer().frame(height: 32)
                        
                        // button
                        HStack {
                            Button(action: {
                                cancleAction?()
                                isPresented = false
                            }) {
                                Text("취소")
                                    .font(.pretendard(size: 16, weight: .semibold))
                                    .foregroundStyle(Color.GrayScale.gray200)
                                    .frame(maxWidth: .infinity, minHeight: 46)
                            }
                            .background(Color(.customGray600))
                            .cornerRadius(8)
                            
                            Spacer().frame(width: 12)
                            
                            Button(action: {
                                confirmAction?()
                                isPresented = false
                            }) {
                                Text("확인")
                                    .font(.pretendard(size: 16, weight: .semibold))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity, minHeight: 46)
                            }
                            .background(Color(.customBlue100))
                            .cornerRadius(8)
                            
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer().frame(width: 30)
                        
                    }
                    .frame(maxWidth: 316, maxHeight: 336)
                    .background(Color(.customGray800))
                    .cornerRadius(8)
                }
                    .isHidden(!isPresented)
                    .onAppear {
                        setCurrentDate()
                    }
                    .onReceive(Publishers.CombineLatest3(selectedHour, selectedMinute, daypart), perform: { hour, minutes, dayPart in
                        let currentHour = Calendar.current.component(.hour, from: .now)
                        let currentMinutes = Calendar.current.component(.minute, from: .now)
                        
                        let hour12 = currentHour % 12 == 0 ? 12 : currentHour % 12
                        if daypart.value.uppercased() == "AM" {
                            minumumHours = min(11, currentHour)
                        } else {
                            minumumHours = hour12
                        }
                        
                        if selectedHour.value < minumumHours {
                            minumumMinutes = 59
                        } else {
                            minumumMinutes = currentMinutes
                        }
                          
                        currentDate = createDate(hour, minutes, dayPart) ?? Date()
                        
                    })
            )
    }
    
    private func setCurrentDate() {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: currentDate)
        let minutes = calendar.component(.minute, from: currentDate)
        let hour12 = hour % 12 == 0 ? 12 : hour % 12
        let daypart = hour < 12 ? "AM" : "PM"
        
        self.selectedHour.send(hour12)
        self.selectedMinute.send(minutes)
        self.daypart.send(daypart)
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
