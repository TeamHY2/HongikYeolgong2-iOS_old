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
    func updateStudyRoomUsageRecord(_ studyRoomUsage: StudyRoomUsage, with email: String) -> AnyPublisher<[StudyRoomUsage], Never>
}

final class StudyRoomRepository: StudyRoomRepositoryType {
    
    func fetchStudyRoomUsageRecords() -> AnyPublisher<[StudyRoomUsage], Never> {
        return Empty().eraseToAnyPublisher()
    }
    
    func updateStudyRoomUsageRecord(_ studyRoomUsage: StudyRoomUsage, with email: String) -> AnyPublisher<[StudyRoomUsage], Never> {
        let ref = FirebaseService.shared.database
            .collection(FirebaseService.Collections.userCollection.rawValue)
            .document(email)
            .collection(FirebaseService.Collections.studyDayCollection.rawValue)
            
       return Future<[StudyRoomUsage], Never> { promise in
            Task {
                do {
                    try await FirebaseService.shared.post(studyRoomUsage, with: ref)
                }
            }
       }.eraseToAnyPublisher()
    }
}
