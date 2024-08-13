//
//  ReadingRoomRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/3/24.
//

import Foundation
import Combine

protocol StudyRoomRepositoryType {
    func fetchStudyRoomUsageRecords(with email: String) -> AnyPublisher<[StudyRoomUsage], Never>
    func updateStudyRoomUsageRecord(_ studyRoomUsage: StudyRoomUsage, with email: String) -> AnyPublisher<[StudyRoomUsage], Never>
}

final class StudyRoomRepository: StudyRoomRepositoryType {
    
    func fetchStudyRoomUsageRecords(with email: String) -> AnyPublisher<[StudyRoomUsage], Never> {
        
        return Future<[StudyRoomUsage], Never> { promise in
            Task {
                do {
                    let studyRoomUsageList: [StudyRoomUsage] = try await FirestoreService.request(Endpoint.fetchStudyDay(email: email))
                    promise(.success(studyRoomUsageList))
                } catch {
                    
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func updateStudyRoomUsageRecord(_ studyRoomUsage: StudyRoomUsage, with email: String) -> AnyPublisher<[StudyRoomUsage], Never> {   
            
       return Future<[StudyRoomUsage], Never> { promise in
            Task {
                do {
                    try await FirestoreService.request(Endpoint.updateStudyDay(email: email, studyRoomUsage))
                    let studyRoomUsageList: [StudyRoomUsage] = try await FirestoreService.request(Endpoint.fetchStudyDay(email: email))
                    promise(.success(studyRoomUsageList))
                } catch {
                    
                }
            }
       }.eraseToAnyPublisher()
    }
}
