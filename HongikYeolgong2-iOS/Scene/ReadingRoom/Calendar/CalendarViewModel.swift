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
    
    @Published var seletedDate = Date() // 선택된 날짜
    @Published var currentMonth = [Day]() // 캘린더에 표시할 날짜정보
    @Published var dailyReadingRoomUsageTime = 0 // 오늘 열람실 이용시간
    
    @Inject private var calendarRepository: CalendarRepositoryType
    
    private let calendar = Calendar.current
    
    private var subscriptions = Set<AnyCancellable>()
    
    enum Action {
        case saveButtonTap(ReadingRoomUsage)
        case moveButtonTap(MoveType)
        case viewOnAppear
    }
    
    func send(action: Action) {
        switch action {
        case .viewOnAppear:
            fetchReadingRoomRecords(for: seletedDate)
        case .moveButtonTap(let moveType):
            changeMonth(moveType)
        case .saveButtonTap(let data):
            updateReadingRoomRecord(data)
        }
    }
}

extension CalendarViewModel {
    // 선택한 달이 변경되는 경우
    func changeMonth(_ moveType: MoveType) {
        var currentDate: Date!
        
        switch moveType {
        case .current:
            currentDate = Date()
        case .next:
            currentDate = plusMonth(date: seletedDate)
        case .prev:
            currentDate = minusMonth(date: seletedDate)
        }
        
        // 현재보다 더 미래의 월이 선택된 경우
        let maximumDateValidate = calendar.compare(currentDate, to: Date(), toGranularity: .month)
        
        // 날짜이동 최소값 날짜생성
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let minimumDate = formatter.date(from: "2021/01")!
        let mimumDateValidate = calendar.compare(currentDate, to: minimumDate, toGranularity: .month)
        
        guard maximumDateValidate != .orderedDescending,
              mimumDateValidate != .orderedAscending else {
            return
        }
        
        seletedDate = currentDate
        
        fetchReadingRoomRecords(for: seletedDate)
    }
    
    // 캘린더에 데이터 가져오기
    func fetchReadingRoomRecords(for date: Date) {
        let fetchDataPublisher = calendarRepository.fetchReadingRoomUsageRecords()
            .share()
        
        fetchDataPublisher
            .withUnretained(self)
            .sink(receiveValue: { (owner, roomUsageInfo) in
                owner.currentMonth = owner.makeMonth(date: date, roomUsageInfo: roomUsageInfo)
            })
            .store(in: &subscriptions)
        
       fetchDataPublisher
            .flatMap ({ [weak self] in
                guard let self = self else {
                    return Just(0).eraseToAnyPublisher()
                }
                return getTotalTime($0)
            })
            .sink { [weak self] totalTime in
                guard let self = self else { return }
                dailyReadingRoomUsageTime = totalTime
            }
            .store(in: &subscriptions)
    }
    
    // 캘린더 데이터 저장
    func updateReadingRoomRecord(_ data: ReadingRoomUsage) {
        let updateDataPublisher = calendarRepository.updateReadingRoomUsageRecord(data).share()
        
        updateDataPublisher
            .withUnretained(self)
            .sink(receiveValue: { (owner, roomUsageInfo) in
                owner.currentMonth = owner.makeMonth(date: owner.seletedDate, roomUsageInfo: roomUsageInfo)
            })
            .store(in: &subscriptions)
        
        updateDataPublisher
            .flatMap ({ [weak self] in
                guard let self = self else {
                    return Just(0).eraseToAnyPublisher()
                }
                return getTotalTime($0)
            })
            .sink { [weak self] totalTime in
                guard let self = self else { return }
                dailyReadingRoomUsageTime = totalTime
            }
            .store(in: &subscriptions)
    }
}

extension CalendarViewModel {
    func getTotalTime(_ array: [ReadingRoomUsage]) -> AnyPublisher<Int, Never> {
       let filterdArray = array.filter { calendar.isDate($0.date, equalTo: Date(), toGranularity: .day)}
        let totalTime = filterdArray.map { $0.duration }.reduce(0, +)
        return Just(totalTime).eraseToAnyPublisher()
    }
    
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
    
    func makeMonth(date: Date, roomUsageInfo: [ReadingRoomUsage]) -> [Day] {
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
                    let matchData = roomUsageInfo.filter { calendar.isDate($0.date, inSameDayAs: currentDay)}
                    days.append(Day(dayOfNumber: "\(numberOfDay)", usageRecord: matchData))
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
