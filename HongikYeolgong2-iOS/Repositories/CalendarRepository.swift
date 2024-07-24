//
//  CalendarRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/21/24.
//

import Foundation
import Combine

protocol CalendarRepositoryType {
    func fetchStudyRecord() -> AnyPublisher<[StudyRecord], Never>
    func updateStudyRecord(_: StudyRecord) -> AnyPublisher<[StudyRecord], Never>
}

// 테스트용 데이터
class CalendarRepositoryMock: CalendarRepositoryType {
    let mockData = CurrentValueSubject<[StudyRecord], Never>([.init(date: Date() - TimeInterval(86400 * 2), totalTime: (3600 * 4)),
                                                     .init(date: Date() - TimeInterval(86400 * 3), totalTime: (3600 * 1)),
                                                     .init(date: Date() - TimeInterval(86400 * 5), totalTime: (3600 * 4)),
                                                     .init(date: Date() - TimeInterval(86400 * 10), totalTime: (3600 * 2)),
                                                     .init(date: Date() - TimeInterval(86400 * 22), totalTime: (3600 * 12)),
                                                     .init(date: Date() - TimeInterval(86400 * 6), totalTime: (3600 * 6)),
                                                     .init(date: Date() - TimeInterval(86400 * 7), totalTime: (3600 * 7)),])
    
    func fetchStudyRecord() -> AnyPublisher<[StudyRecord], Never> {
        return mockData.eraseToAnyPublisher()
    }
    
    func updateStudyRecord(_ data: StudyRecord) -> AnyPublisher<[StudyRecord], Never> {        
        mockData.send(mockData.value + [data])
        return mockData.eraseToAnyPublisher()
    }
}
