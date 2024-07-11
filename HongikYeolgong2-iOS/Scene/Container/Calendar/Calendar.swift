//
//  Calendar.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import SwiftUI
import Combine

enum WeekDay: String, CaseIterable {
    case sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
}

struct CalendarView: View {
    @State private var selecteDate = Date()
    @State private var currentMonth = [Day]()
    
    private let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            // header
            HStack(spacing: 0) {
                CustomText(font: .suite, title: "\(selecteDate.getMonthString()) \(selecteDate.getYearString())", textColor: .customGray100, textWeight: .bold, textSize: 24)
                Spacer()
                HStack {
                    Button(action: {
                        selecteDate = CalendarManager.shared.minusMonth(date: selecteDate)
                    }) {
                        Image(.icCalendarLeft)
                    }
                    
                    Spacer().frame(width: UIScreen.UIWidth(7))
                    
                    Button(action: {
                        selecteDate = CalendarManager.shared.plusMonth(date: selecteDate)
                    }) {
                        Image(.icCalendarRight)
                    }
                }
            }
            
            Spacer().frame(height: UIScreen.UIHeight(12))
            
            // weakday
            HStack(alignment: .center) {
                ForEach(WeekDay.allCases, id: \.rawValue) {
                    CustomText(font: .suite, title: $0.rawValue, textColor: .customGray300, textWeight: .medium, textSize: 12)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Spacer().frame(height: UIScreen.UIHeight(8))
            // seleteMonth가 변경될때마다 makeMonth의 값을 받아서 currentMonth에 업데이트
            // grid
            LazyVGrid(columns: columns, spacing: UIScreen.UIWidth(5)) {
                ForEach(currentMonth, id: \.id) {
                    CalendarCell(dayOfNumber: $0.dayOfNumber)
                }
            }
            .onAppear {
                CalendarManager.shared
                    .makeMonth(date: selecteDate)
                    .assign(to: \.currentMonth, on: self)
                    .cancel()
            }
            .onChange(of: selecteDate) { date in
                CalendarManager.shared
                    .makeMonth(date: date)
                    .assign(to: \.currentMonth, on: self)
                    .cancel()
            }
        }
    }
}

#Preview {
    CalendarView()
}
