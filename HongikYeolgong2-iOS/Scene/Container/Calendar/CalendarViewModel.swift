//
//  CalendarViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/24/24.
//

import Foundation
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

final class CalendarViewModel: ViewModelType {
    enum DateMove {
        case current
        case next
        case prev
    }
    
    @Published var selecteDate = Date()
    @Published var currentMonth = [Day]()
    
    @Inject private var calendarRepository: CalendarRepositoryType
    
    private let calendar = Calendar.current
    
    private var cancellables = Set<AnyCancellable>()
    
    enum Action {
        case move(DateMove)
        case viewOnAppear
    }
    
    func send(action: Action) {
        switch action {
        case .move(let move):
            if move == .next {
                selecteDate = plusMonth(date: selecteDate)
            } else if move == .prev {
                selecteDate = minusMonth(date: selecteDate)
            } else if move == .current {
                selecteDate = Date()
            }
            currentMonth = makeMonth(date: selecteDate)
        case .viewOnAppear:
             currentMonth = makeMonth(date: selecteDate)      
        }
    }
}

extension CalendarViewModel {
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
    
    func daysOfMonth(date: Date) -> Int {
        let componets = calendar.dateComponents([.day], from: date)
        return componets.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func makeMonth(date: Date) -> [Day] {
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
                    return []
                }
                days.append(Day(dayOfNumber: "\(count - startingSpace)"))
            }
            count += 1
        }
        return days
    }
}
