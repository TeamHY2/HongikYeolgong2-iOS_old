//
//  Endpoint.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/13/24.
//

import Foundation

enum Endpoint: FirestoreEndpoint {
    case fetchUser(email: String)
    case createUser(User)
    case fetchStudyDay(email: String)
    case updateStudyDay(email: String, StudyRoomUsage)
    
    var path: FirestoreReference {
        switch self {
        case .fetchUser(let email):
            return firestore.collection("User").document(email)
        case .createUser(let user):
            return firestore.collection("User").document(user.email)
        case .fetchStudyDay(let email):
            return firestore.collection("User").document(email).collection("StudyDay")
        case .updateStudyDay(let email, _):
            return firestore.collection("User").document(email).collection("StudyDay").document()
        }
    }
    
    var method: FirestoreMethod {
        switch self {
        case .fetchUser(_):
            return .get
        case .createUser(let user):
            return .post(user)
        case .fetchStudyDay(_):
            return .get
        case .updateStudyDay(_, let studyRoomUsage):
            return .post(studyRoomUsage)
        }
    }
}
