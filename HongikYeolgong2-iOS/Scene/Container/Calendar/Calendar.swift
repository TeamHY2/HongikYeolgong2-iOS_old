//
//  Calendar.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import SwiftUI

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
    
    private let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    private let days = Array(1...42).map { String($0) }
    
    var body: some View {
        VStack(spacing: 0) {
            // header
            HStack(spacing: 0) {
                CustomText(font: .suite, title: "Jan 2024", textColor: .customGray100, textWeight: .bold, textSize: 24)
                Spacer()
                HStack {
                    Button(action: {}) {
                        Image(.icCalendarLeft)
                    }
                    
                    Spacer().frame(width: UIScreen.UIWidth(7))
                    
                    Button(action: {}) {
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
            
            // grid
            LazyVGrid(columns: columns, spacing: UIScreen.UIWidth(5)) {
                ForEach(days, id: \.self) {
                    CalendarCell(dayOfNumber: $0)                        
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}
