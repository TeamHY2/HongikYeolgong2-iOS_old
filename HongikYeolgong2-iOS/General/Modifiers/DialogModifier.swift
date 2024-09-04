//
//  DialogModifier.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/10/24.
//

import SwiftUI
import Combine


struct DialogModifier: ViewModifier {
    
    enum DayPart: Comparable {
        case am
        case pm
    }
    
    private let calendar = Calendar(identifier: .gregorian)
    private let hours = Array(repeating: Array(1...12), count: 100).flatMap { $0 }
    private let minutes = Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    private let dayParts: [DayPart] = [.am, .pm]
    
    private var cancelablles = Set<AnyCancellable>()
    
    @State private var currentHour = CurrentValueSubject<Int, Never>(0)
    @State private var currentMinutes = CurrentValueSubject<Int, Never>(0)
    @State private var currentDaypart = CurrentValueSubject<DayPart, Never>(.am)
    
    @State private var seletedHour = 0
    @State private var seletedMinutes = 0
    @State private var seletedDaypart: DayPart = .am
    
    @Binding var isPresented: Bool
    @Binding var currentDate: Date
    
    let confirmAction: (() -> ())?
    let cancleAction: (() -> ())?
    
    init(isPresented: Binding<Bool>, currentDate: Binding<Date>, confirmAction: @escaping () -> (), cancelAction: (() -> ())? = nil) {
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
                    .isHidden(!isPresented)
                    .onAppear {
                        let hour = calendar.component(.hour, from: currentDate)
                        let minutes = calendar.component(.minute, from: currentDate)
                        let hour12 = hour % 12 == 0 ? 12 : hour % 12
                        let dayPart: DayPart = hour < 12 ? .am : .pm
                        
                        currentHour.send(hour12)
                        currentMinutes.send(minutes)
                        currentDaypart.send(dayPart)
                        
                        seletedDaypart = dayPart
                        seletedHour = hour12
                        seletedMinutes = minutes
                    }
                    .onReceive(Publishers.CombineLatest3(currentHour, currentMinutes, currentDaypart), perform: { newHour, newMinutes, newDaypart in
                        
                        let currentDateComponets = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
                        var newDateComponets = currentDateComponets
                        
                        var adjustedHour = newHour
                        
                        if newDaypart == .pm && newHour < 12 {
                            adjustedHour += 12
                        } else if newDaypart == .am && newHour == 12 {
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
                            daypart = hour < 12 ? .am : .pm
                        }
                        
                        seletedHour = hour
                        seletedMinutes = minutes
                        seletedDaypart = daypart
                    })
                
            )
    }
}

