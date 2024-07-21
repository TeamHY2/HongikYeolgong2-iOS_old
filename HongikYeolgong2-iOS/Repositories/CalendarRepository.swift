//
//  CalendarRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/21/24.
//

import Foundation
import Combine

protocol CalendarRepositoryType {
    func fetch() -> AnyPublisher<[Day], Never>
    func insert() -> AnyPublisher<Void, Never>
}

class CalendarRepositoryMock: CalendarRepositoryType {
    let mockData: [Day] = []
    func fetch() -> AnyPublisher<[Day], Never> {
        Just(mockData).eraseToAnyPublisher()
    }
    
    func insert() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
