//
//  CalendarCell.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import SwiftUI

struct CalendarCell: View {
    let dayOfNumber: String
    
    var body: some View {
        VStack {
            CustomText(font: .suite, title: dayOfNumber, textColor: .customGray300, textWeight: .medium, textSize: 14)
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.UIHeight(33))
        .background(Color(.customGray800))
        .cornerRadius(8)
    }
}

#Preview {
    CalendarCell(dayOfNumber: "1")
}
