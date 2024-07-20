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
                ZStack(alignment: .myAlignment) {
                    CustomText(font: .suite, title: "Start", textColor: .customGray300, textWeight: .medium, textSize: 12)
                        .alignmentGuide(.hAlignment) { d in
                            d[.trailing]
                        }
                    
                    Image(.arrow)
                        .alignmentGuide(.hAlignment) { d in
                            d[.leading] - 12
                        }
                        .alignmentGuide(.vAlignment) { d in
                            d[.bottom] + (d.height / 2)
                        }
                        
                    HStack(alignment: .lastTextBaseline)  {
                        CustomText(font: .suite, title: startTime.getHourMinutes(), textColor: .customGray100, textWeight: .extrabold, textSize: 30)
                        CustomText(font: .suite, title: startTime.getDaypart(), textColor: .customGray100, textWeight: .medium, textSize: 14)
                    }
                    .alignmentGuide(.hAlignment, computeValue: { d in
                        d[.lastTextBaseline]
                    })
                    .alignmentGuide(.vAlignment) { d in
                        d[.top] - 11
                    }
                }
                
                VStack(alignment: .leading) {
                    CustomText(font: .suite, title: "End", textColor: .customGray300, textWeight: .medium, textSize: 12)
                    
                    Spacer().frame(height: UIScreen.UIHeight(11))
                    
                    HStack(alignment: .lastTextBaseline) {
                        CustomText(font: .suite, title: endTime.getHourMinutes(), textColor: .customGray100, textWeight: .extrabold, textSize: 30)
                        CustomText(font: .suite, title: endTime.getDaypart(), textColor: .customGray100, textWeight: .medium, textSize: 14)
                    }
                    
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

extension HorizontalAlignment {
    private enum MyHorizontalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[HorizontalAlignment.leading]
        }
    }
        
    static let hAlignment = HorizontalAlignment(MyHorizontalAlignment.self)
}

extension VerticalAlignment {
    private enum MyVerticalAlignment : AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            return d[VerticalAlignment.bottom]
        }
    }
    
    static let vAlignment = VerticalAlignment(MyVerticalAlignment.self)
}

extension Alignment {
    static let myAlignment = Alignment(horizontal: .hAlignment, vertical: .vAlignment)
}

#Preview {
    TimeLapse(startTime: Date(), endTime: Date())
}
