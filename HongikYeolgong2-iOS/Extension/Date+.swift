//
//  Date+.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/11/24.
//

import Foundation

extension Date {
    func getHourMinutes() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let hour12 = hour % 12 == 0 ? 12 : hour % 12
        
        return "\(hour12):\(minutes)"
    }
    
    func getDaypart() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let daypart = hour < 12 ? "AM" : "PM"
        return daypart
    }
}
