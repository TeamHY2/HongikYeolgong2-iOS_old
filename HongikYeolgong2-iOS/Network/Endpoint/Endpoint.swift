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
    case deleteUser(User)
    case checkUserNickname(String)
    case deleteCollection(User)
    
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
        case .deleteUser(let user):
            return firestore.collection("User").document(user.id)
        case .deleteCollection(let user):
            return firestore.collection("User").document(user.id).collection("StudyDay").document()
        case .checkUserNickname(_):
            return firestore.collection("User")
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
        case .deleteUser(_):
            return .delete
        case .deleteCollection(_):
            return.deleteCollection
        case .checkUserNickname(let nickname):
            return .query(field: "nickname", isEqaulTo: nickname)
        }
    }
}
