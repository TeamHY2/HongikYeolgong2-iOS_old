//
//  ReadingRoomRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/3/24.
//

import Foundation
import Combine

protocol StudyRoomRepositoryType {
    func fetchStudyRoomUsageRecords() -> AnyPublisher<[StudyRoomUsage], Never>
    func updateStudyRoomUsageRecord(_: StudyRoomUsage) -> AnyPublisher<[StudyRoomUsage], Never>
}

// 테스트용 데이터
class MockStudyRoomRepository: StudyRoomRepositoryType {
    let mockData = CurrentValueSubject<[StudyRoomUsage], Never>([])
    
    func fetchStudyRoomUsageRecords() -> AnyPublisher<[StudyRoomUsage], Never> {
        return Just(mockData.value).eraseToAnyPublisher()
    }
    
    func updateStudyRoomUsageRecord(_ data: StudyRoomUsage) -> AnyPublisher<[StudyRoomUsage], Never> {
        mockData.send(mockData.value + [data])
        return Just(mockData.value).eraseToAnyPublisher()
    }
}
