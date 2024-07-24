//
//  CalendarViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/24/24.
//

import Foundation
import Combine

final class CalendarViewModel: ViewModelType {
    
    enum MoveType {
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
        case move(MoveType)
        case viewOnAppear
    }
    
    func send(action: Action) {
        switch action {
        case .move(let moveType):
            changeMonth(moveType)
        case .viewOnAppear:
             getMonth()
        }
    }
}

extension CalendarViewModel {
    // 선택한 달이 변경되는 경우
    func changeMonth(_ moveType: MoveType) {
        switch moveType {
        case .current:
            selecteDate = Date()
        case .next:
            selecteDate = plusMonth(date: selecteDate)
        case .prev:
            selecteDate = minusMonth(date: selecteDate)
        }
        
        fetchStudyRecord(for: selecteDate)
    }
    
    // 앱이 처음 실행됬을때 데이터를 받아옴
    func getMonth() {
        fetchStudyRecord(for: selecteDate)
    }
    
    func fetchStudyRecord(for date: Date) {
        calendarRepository.fetchStudyRecord()
            .sink { completion in
                
            } receiveValue: { [weak self] studyArray in
                guard let self = self else { return }
                currentMonth = makeMonth(date: date, studyArray: studyArray)
            }
            .store(in: &cancellables)
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
    
    func makeMonth(date: Date, studyArray: [StudyRecord]) -> [Day] {
        var days: [Day] = []
        var count: Int = 1
        
        let daysInMonth = daysInMonth(date: date)
        let firstDayOfMonth = firstOfMonth(date: date)
        let startingSpace = weekDay(date: firstDayOfMonth)
                
        while(count <= 42) {
            // 이번달이 아닌경우 공백 처리
            if (count <= startingSpace || count - startingSpace > daysInMonth) {
                days.append(Day(dayOfNumber: ""))
            }
            
            else {
                let numberOfDay = count - startingSpace
                
                guard calendar.date(byAdding: .day, value: numberOfDay - 1, to: firstOfMonth(date: date)) != nil else {
                    return []
                }
                // 현재날짜 생성
                var components = calendar.dateComponents([.year, .month, .day], from: date)
                components.day = numberOfDay
                
                // 현재날짜와 서버에서 받아온 데이터의 날짜가 일치하는지 확인
                if let currentDay = calendar.date(from: components) {
                    let matchData = studyArray.filter { calendar.isDate($0.date, inSameDayAs: currentDay)}
                    days.append(Day(dayOfNumber: "\(numberOfDay)", studyRecord: matchData))
                } else {
                    // 일치하는 데이터가 존재하지 않는경우
                    days.append(Day(dayOfNumber: "\(numberOfDay)"))
                }
                
            }
            count += 1
        }
        return days
    }
}