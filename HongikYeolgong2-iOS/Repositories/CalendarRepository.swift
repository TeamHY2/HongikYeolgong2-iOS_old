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
    let mockData = CurrentValueSubject<[StudyRecord], Never>([])
    
    func fetchStudyRecord() -> AnyPublisher<[StudyRecord], Never> {
        return Just(mockData.value).eraseToAnyPublisher()
    }
    
    func updateStudyRecord(_ data: StudyRecord) -> AnyPublisher<[StudyRecord], Never> {        
        mockData.send(mockData.value + [data])
        return Just(mockData.value).eraseToAnyPublisher()
    }
}
