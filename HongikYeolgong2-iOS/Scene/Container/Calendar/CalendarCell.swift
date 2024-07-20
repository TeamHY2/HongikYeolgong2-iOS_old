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
    let dayOfNumber: String
    let cellStyle: CellStyle = .dayCount00
    
    var body: some View {
        
        switch cellStyle {
        case .dayCount00:
            VStack {
                CustomText(font: .suite, title: dayOfNumber, textColor: .customGray300, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Color(.customGray800))
            .cornerRadius(8)
            .opacity(dayOfNumber.isEmpty ? 0 : 1)
        case .dayCount01:
            VStack {
                CustomText(font: .suite, title: dayOfNumber, textColor: .customGray100, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount01))
            .cornerRadius(8)
            .opacity(dayOfNumber.isEmpty ? 0 : 1)
        case .dayCount02:
            VStack {
                CustomText(font: .suite, title: dayOfNumber, textColor: .white, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount02))
            .cornerRadius(8)
            .opacity(dayOfNumber.isEmpty ? 0 : 1)
        case .dayCount03:
            VStack {
                CustomText(font: .suite, title: dayOfNumber, textColor: .customGray600, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount03))
            .cornerRadius(8)
            .opacity(dayOfNumber.isEmpty ? 0 : 1)
        }
        
        
    }
}

#Preview {
    CalendarCell(dayOfNumber: "1")
}
