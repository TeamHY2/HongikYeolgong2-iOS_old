//
//  Endpoint.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/13/24.
//

import Foundation

enum Endpoint: FirestoreEndpoint {
    case fetchUser(uid: String)
    case createUser(User)
    case fetchStudyDay(uid: String)
    case updateStudyDay(uid: String, StudyRoomUsage)
    
    var path: FirestoreReference {
        switch self {
        case .fetchUser(let uid):
            return firestore.collection("User").document(uid)
        case .createUser(let user):
            return firestore.collection("User").document(user.id)
        case .fetchStudyDay(let uid):
            return firestore.collection("User").document(uid).collection("StudyDay")
        case .updateStudyDay(let uid, _):
            return firestore.collection("User").document(uid).collection("StudyDay").document()
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
