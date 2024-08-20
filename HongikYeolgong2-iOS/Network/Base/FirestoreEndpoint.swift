//
//  FirestoreEndpoint.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/13/24.
//

import FirebaseFirestore

protocol FirestoreEndpoint {
    var path: FirestoreReference { get }
    var method: FirestoreMethod { get }
    var firestore: Firestore { get }
}

extension FirestoreEndpoint {
    var firestore: Firestore {
        Firestore.firestore()
    }
}

enum FirestoreMethod {    
    case get
    case post(any FirestoreIdentifiable)
    case put(any FirestoreIdentifiable)
    case delete
    case deleteCollection
}

protocol FirestoreReference {}

extension DocumentReference: FirestoreReference { }
extension CollectionReference: FirestoreReference { }
