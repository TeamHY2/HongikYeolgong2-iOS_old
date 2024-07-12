//
//  CalendarManager.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import Foundation
import Combine

final class CalendarManager {
    static let shared = CalendarManager()
    
    private init() {}
    
    let calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    /// 현재 날짜
    func daysOfMonth(date: Date) -> Int {
        let componets = calendar.dateComponents([.day], from: date)
        return componets.day!
    }
    
    /// 현재 달의 첫번째 날에대한 정보
    func firstOfMonth(date: Date) -> Date {
        
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func makeMonth(date: Date) -> AnyPublisher<[Day], Never> {
        let daysInMonth = daysInMonth(date: date)
        let firstDayOfMonth = firstOfMonth(date: date)
        let startingSpace = weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        var days: [Day] = []
        
        while(count <= 42) {
            if (count <= startingSpace || count - startingSpace > daysInMonth) {
                days.append(Day(dayOfNumber: ""))
            }
            else {
                let numberOfDay = count - startingSpace
                guard calendar.date(byAdding: .day, value: numberOfDay - 1, to: firstOfMonth(date: date)) != nil else {
                    return Just([]).eraseToAnyPublisher()
                }
                days.append(Day(dayOfNumber: "\(count - startingSpace)"))
            }
            count += 1
        }
        return Just(days).eraseToAnyPublisher()
    }
}
