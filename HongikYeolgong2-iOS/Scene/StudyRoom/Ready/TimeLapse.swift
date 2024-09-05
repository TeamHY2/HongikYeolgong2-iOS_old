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
    let timeRemaining: Double
    let usageCount: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        Text("Start")
                            .font(.suite(size: 12, weight: .medium))
                            .foregroundStyle(Color.GrayScale.gray300)
                        
                        Image(.arrow)
                            .offset(y: -4)
                    }
                    
                    Spacer()
                        .frame(height: UIScreen.UIHeight(11))
                    
                    HStack(alignment: .firstTextBaseline)  {
                        Text(startTime.getHourMinutes())
                            .font(.suite(size: 30, weight: .extrabold))
                            .foregroundStyle(Color.GrayScale.gray100)
                        
                        Text(startTime.getDaypart())
                            .font(.suite(size: 14, weight: .medium))
                            .foregroundStyle(Color.GrayScale.gray100)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("End")
                            .font(.suite(size: 12, weight: .medium))
                            .foregroundColor(Color.GrayScale.gray300)
                        
                        Image(.arrow)
                            .offset(y: -4)
                            .opacity(0)
                    }
                    
                    Spacer()
                        .frame(height: UIScreen.UIHeight(11))
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text(endTime.getHourMinutes())
                            .font(.suite(size: 30, weight: .extrabold))
                            .foregroundStyle(Color.GrayScale.gray100)
                        
                        Text(endTime.getDaypart())
                            .font(.suite(size: 14, weight: .medium))
                            .foregroundStyle(Color.GrayScale.gray100)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
                .frame(height: UIScreen.UIHeight(32))
            
            // 남은 시간
            HStack {
                Text("Time Left")
                    .font(.suite(size: 12, weight: .medium))
                    .foregroundStyle(Color.GrayScale.gray300)
                Spacer()
            }
            
            Spacer()
                .frame(height: UIScreen.UIHeight(11))
            
            HStack {                
                Text(timeRemaining.getFullTimeString())
                    .font(.suite(size: 30, weight: .extrabold))
                    .foregroundStyle(timeRemaining <= (30) ? Color.Secondary.yellow100 : Color.GrayScale.gray100)
                Spacer()
                
                HStack {
                    Image(.shineCount01)
                    Image(usageCount >= 1 ? .shineCount02 : .shineCount00)
                    Image(usageCount >= 2 ? .shineCount03 : .shineCount00)
                }
            }
        }
    }
}

extension Double {
    func getFullTimeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        let formattedString = formatter.string(from: TimeInterval(self))!
        return formattedString
    }    
}
