//
//  ReadingRoomRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/3/24.
//

import Foundation
import Combine

protocol StudyRoomRepositoryType {
    func fetchReadingRoomUsageRecords() -> AnyPublisher<[StudyRoomUsage], Never>
    func updateReadingRoomUsageRecord(_: StudyRoomUsage) -> AnyPublisher<[StudyRoomUsage], Never>
}

// 테스트용 데이터
class MockStudyRoomRepository: StudyRoomRepositoryType {
    let mockData = CurrentValueSubject<[StudyRoomUsage], Never>([])
    
    func fetchReadingRoomUsageRecords() -> AnyPublisher<[StudyRoomUsage], Never> {
        return Just(mockData.value).eraseToAnyPublisher()
    }
    
    func updateReadingRoomUsageRecord(_ data: StudyRoomUsage) -> AnyPublisher<[StudyRoomUsage], Never> {
        mockData.send(mockData.value + [data])
        return Just(mockData.value).eraseToAnyPublisher()
    }
}
