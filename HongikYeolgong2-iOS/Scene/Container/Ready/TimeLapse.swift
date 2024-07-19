//
//  TimeLapse.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/8/24.
//

import SwiftUI

struct TimeLapse: View {
    let startTime: Date
    let endTime: Date
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                CustomText(font: .suite, title: "Start", textColor: .customGray300, textWeight: .medium, textSize: 12)
                
                Image(.arrow)
                
                CustomText(font: .suite, title: "End", textColor: .customGray300, textWeight: .medium, textSize: 12)
                Spacer()
            }
            
            Spacer()
                .frame(height: UIScreen.UIHeight(11))
            
            // 이용 시간
            HStack {
                HStack {
                    CustomText(font: .suite, title: startTime.getHourMinutes(), textColor: .customGray100, textWeight: .extrabold, textSize: 30)
                    CustomText(font: .suite, title: startTime.getDaypart(), textColor: .customGray100, textWeight: .medium, textSize: 14)
                }
                
                Spacer()
                    .frame(width: UIScreen.UIWidth(30))
                
                HStack {
                    CustomText(font: .suite, title: endTime.getHourMinutes(), textColor: .customGray100, textWeight: .extrabold, textSize: 30)
                    CustomText(font: .suite, title: endTime.getDaypart(), textColor: .customGray100, textWeight: .medium, textSize: 14)
                }
                Spacer()
            }
            
            Spacer()
                .frame(height: UIScreen.UIHeight(32))
            
            // 남은 시간
            HStack {
                CustomText(font: .suite, title: "Time Left", textColor: .customGray300, textWeight: .medium, textSize: 12)
                Spacer()
            }
           
            Spacer()
                .frame(height: UIScreen.UIHeight(11))
            
            HStack {
                CustomText(font: .suite, title: "03:52:00", textColor: .customGray100, textWeight: .extrabold, textSize: 30)
                
                Spacer()
                
                HStack {
                    Image(.shineCount00)
                    Image(.shineCount00)
                    Image(.shineCount00)
                }
            }
        }
    }
}

#Preview {
    TimeLapse(startTime: Date(), endTime: Date())
}
