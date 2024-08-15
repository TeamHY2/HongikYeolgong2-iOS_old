//
//  ReadingRoomRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/3/24.
//

import Foundation
import Combine

protocol StudyRoomRepositoryType {
    func fetchStudyRoomUsageRecords(with uid: String) -> AnyPublisher<[StudyRoomUsage], Error>
    func updateStudyRoomUsageRecord(_ studyRoomUsage: StudyRoomUsage, with uid: String) -> AnyPublisher<[StudyRoomUsage], Never>
}

final class StudyRoomRepository: StudyRoomRepositoryType {
    
    func fetchStudyRoomUsageRecords(with uid: String) -> AnyPublisher<[StudyRoomUsage], Error> {
        
        return Future<[StudyRoomUsage], Error> { promise in
            Task {
                do {
                    let studyRoomUsageList: [StudyRoomUsage] = try await FirestoreService.request(Endpoint.fetchStudyDay(uid: uid))
                    promise(.success(studyRoomUsageList))
                } catch {                    
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func updateStudyRoomUsageRecord(_ studyRoomUsage: StudyRoomUsage, with uid: String) -> AnyPublisher<[StudyRoomUsage], Never> {
            
       return Future<[StudyRoomUsage], Never> { promise in
            Task {
                do {
                    try await FirestoreService.request(Endpoint.updateStudyDay(uid: uid, studyRoomUsage))
                    let studyRoomUsageList: [StudyRoomUsage] = try await FirestoreService.request(Endpoint.fetchStudyDay(uid: uid))
                    promise(.success(studyRoomUsageList))
                } catch {
                    
                }
            }
       }.eraseToAnyPublisher()
    }
}
