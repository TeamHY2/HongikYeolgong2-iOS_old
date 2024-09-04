//
//  DialogModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/10/24.
//

import SwiftUI
import Combine

struct TimePickerDialogModifier: ViewModifier {
    
    enum DayPart: Comparable {
        case AM
        case PM
    }
    
    private let calendar = Calendar(identifier: .gregorian)
    private let hours = Array(repeating: Array(1...12), count: 100).flatMap { $0 }
    private let minutes = Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    private let dayParts: [DayPart] = [.AM, .PM]
    
    private var cancelablles = Set<AnyCancellable>()
    
    @State private var currentHour = CurrentValueSubject<Int, Never>(0)
    @State private var currentMinutes = CurrentValueSubject<Int, Never>(0)
    @State private var currentDaypart = CurrentValueSubject<DayPart, Never>(.AM)
    
    @State private var seletedHour = 0
    @State private var seletedMinutes = 0
    @State private var seletedDaypart: DayPart = .AM
    
    @Binding var isPresented: Bool
    @Binding var currentDate: Date
    
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
            .overlay {
                if isPresented {
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
                                HY2Picker(selectedValue: $currentHour.value,
                                          currentValue: $seletedHour,
                                          items: hours)
                                
                                Text(":")
                                    .font(.suite(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                                
                                HY2Picker(selectedValue: $currentMinutes.value,
                                          currentValue: $seletedMinutes,
                                          items: minutes)
                                
                                HY2Picker(selectedValue: $currentDaypart.value,
                                          currentValue: $seletedDaypart,
                                          items: dayParts)
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
                                    currentDate = Date()
                                }) {
                                    Text("취소")
                                        .font(.pretendard(size: 16, weight: .semibold))
                                        .foregroundStyle(Color.GrayScale.gray200)
                                        .frame(maxWidth: .infinity, minHeight: 46)
                                }
                                .background(Color.GrayScale.gray600)
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
                                .background(Color.Primary.blue100)
                                .cornerRadius(8)
                                
                            }
                            .padding(.horizontal, 24)
                            
                            Spacer().frame(width: 30)
                            
                        }
                        .frame(maxWidth: 316, maxHeight: 336)
                        .background(Color.GrayScale.gray800)
                        .cornerRadius(8)
                    }
                        .onChange(of: isPresented == true, perform: { isPresented in
                            if isPresented {
                                clearSelectedTime()
                            }
                        })
                        .onAppear { clearSelectedTime() }
                        .onReceive(Publishers.CombineLatest3(currentHour, currentMinutes, currentDaypart), perform: { newHour, newMinutes, newDaypart in
                            
                            let currentDateComponets = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
                            var newDateComponets = currentDateComponets
                            
                            var adjustedHour = newHour
                            
                            if newDaypart == .PM && newHour < 12 {
                                adjustedHour += 12
                            } else if newDaypart == .AM && newHour == 12 {
                                adjustedHour = 0
                            }
                            
                            newDateComponets.hour = adjustedHour
                            newDateComponets.minute = newMinutes
                            
                            guard let seletedDate = calendar.date(from: newDateComponets),
                                  let currentDate = calendar.date(from: currentDateComponets) else { return }
                            
                            var hour, minutes: Int
                            var daypart: DayPart
                            
                            if seletedDate <= currentDate {
                                hour = adjustedHour % 12 == 0 ? 12 : adjustedHour % 12
                                minutes = newMinutes
                                daypart = newDaypart
                            } else {
                                hour = currentDateComponets.hour! % 12 == 0 ? 12 : currentDateComponets.hour! % 12
                                minutes = currentDateComponets.minute!
                                daypart = hour < 12 ? .AM : .PM
                            }
                            
                            self.seletedHour = hour
                            self.seletedMinutes = minutes
                            self.seletedDaypart = daypart
                            
                            if daypart == .PM && hour < 12 {
                                hour += 12
                            } else if daypart == .AM && hour == 12 {
                                hour = 0
                            }
                            
                            var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
                            dateComponents.hour = hour
                            dateComponents.minute = minutes
                            
                            guard let newDate = calendar.date(from: dateComponents) else {
                                return
                            }
                            
                            self.currentDate = newDate
                        })
                }
            }
    }
    
    private func clearSelectedTime() {
        let hour = calendar.component(.hour, from: .now)
        let minutes = calendar.component(.minute, from: .now)
        let hour12 = hour % 12 == 0 ? 12 : hour % 12
        let dayPart: DayPart = hour < 12 ? .AM : .PM
        
        currentHour.send(hour12)
        currentMinutes.send(minutes)
        currentDaypart.send(dayPart)
        
        seletedDaypart = dayPart
        seletedHour = hour12
        seletedMinutes = minutes
    }
}

extension View {
    func dialog(isPresented: Binding<Bool>, currentDate: Binding<Date>, confirmAction: @escaping () -> (), cancelAction: @escaping () -> ()) -> some View {
        modifier(TimePickerDialogModifier(isPresented: isPresented, currentDate: currentDate, confirmAction: confirmAction, cancelAction: cancelAction))
    }
    
    func dialog(isPresented: Binding<Bool>, currentDate: Binding<Date>, confirmAction: @escaping () -> ()) -> some View {
        modifier(TimePickerDialogModifier(isPresented: isPresented, currentDate: currentDate, confirmAction: confirmAction))
    }
}
