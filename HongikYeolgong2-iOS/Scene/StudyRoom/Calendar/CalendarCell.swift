//
//  CalendarCell.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import SwiftUI

enum CellStyle: CaseIterable {
    case dayCount00
    case dayCount01
    case dayCount02
    case dayCount03
}

struct CalendarCell: View {
    
    let dayInfo: Day
    
    private var cellStyle: CellStyle {
        if dayInfo.todayUsageCount >= 3 {
            return .dayCount03
        } else if dayInfo.todayUsageCount >= 2 {
            return .dayCount02
        } else if dayInfo.todayUsageCount >= 1 {
            return .dayCount01
        } else {
            return .dayCount00
        }
    }
    
    private var isVisible: Bool {
        dayInfo.dayOfNumber.isEmpty
    }
    
    var body: some View {
        switch cellStyle {
        case .dayCount00:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.GrayScale.gray300)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Color.GrayScale.gray800)
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount01:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.GrayScale.gray100)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount01))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount02:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount02))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount03:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.GrayScale.gray600)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount03))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        }
    }
}

#Preview {
    CalendarCell(dayInfo: Day(dayOfNumber: "1"))
}
