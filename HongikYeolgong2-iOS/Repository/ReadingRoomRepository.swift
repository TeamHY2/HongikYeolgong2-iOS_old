//
//  ReadingRoomRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/3/24.
//

import Foundation
import Combine

protocol ReadingRoomRepositoryType {
    func fetchReadingRoomUsageRecords() -> AnyPublisher<[ReadingRoomUsage], Never>
    func updateReadingRoomUsageRecord(_: ReadingRoomUsage) -> AnyPublisher<[ReadingRoomUsage], Never>
}

// 테스트용 데이터
class MockReadingRoomRepository: ReadingRoomRepositoryType {
    let mockData = CurrentValueSubject<[ReadingRoomUsage], Never>([])
    
    func fetchReadingRoomUsageRecords() -> AnyPublisher<[ReadingRoomUsage], Never> {
        return Just(mockData.value).eraseToAnyPublisher()
    }
    
    func updateReadingRoomUsageRecord(_ data: ReadingRoomUsage) -> AnyPublisher<[ReadingRoomUsage], Never> {
        mockData.send(mockData.value + [data])
        return Just(mockData.value).eraseToAnyPublisher()
    }
}
