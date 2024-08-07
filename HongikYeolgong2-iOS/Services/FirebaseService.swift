//
//  FirebaseService.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

enum FIrebaseError: Error {
    case someError
}

protocol FirebaseIdentifiable: Hashable, Codable {
    var id: String { get set }
}

final class FirebaseService {
    
    static let shared = FirebaseService()
    let database = Firestore.firestore()
    
    private init() {}
    
    enum Collections: String {
        case userCollection = "User"
        case studyDayCollection = "StudyDay"
    }
}

// MARK: - GET
extension FirebaseService {
    
    func getOne<T: Decodable>(of type: T, with query: Query) async -> Result<T, FIrebaseError> {
           do {
               
               let querySnapshot = try await query.getDocuments()
               if let document = querySnapshot.documents.first {
               
                   let data = try document.data(as: T.self)
                   return .success(data)
               } else {
                   print("Warning: \(#function) document not found")
                   return .failure(.someError)
               }
           } catch let error {
               print("Error: \(#function) couldn't access snapshot, \(error)")
               return .failure(.someError)
           }
       }
    
    func getMany<T: Decodable>(of type: T,with query: Query) async -> Result<[T], Error> {
        do {
            
            var response: [T] = []
            let querySnapshot = try await query.getDocuments()
            
            for document in querySnapshot.documents {
                do {
                    
                    let data = try document.data(as: T.self)
                    response.append(data)
                } catch let error {
                    print("Error: \(#function) document(s) not decoded from data, \(error)")
                    return .failure(error)
                }
            }
            
            return .success(response)
        } catch let error {
            print("Error: couldn't access snapshot, \(error)")
            return .failure(error)
        }
    }
}

// MARK: - POST
extension FirebaseService {
    @discardableResult
    func post<T: FirebaseIdentifiable>(_ value: T, to collection: Collections) async throws -> T {
        // document 저장
        let ref = database.collection(collection.rawValue).document()
        var valueToWrite: T = value
        valueToWrite.id = ref.documentID
        do {
        
            try ref.setData(from: valueToWrite)
            return valueToWrite
        } catch let error {
            print("Error: \(#function) in collection: \(collection), \(error)")
            throw error
        }
    }
    
    @discardableResult
    func post<T: FirebaseIdentifiable>(_ value: T, docId: String, to collection: Collections) async throws -> T {
        // document 저장
        let ref = database.collection(collection.rawValue).document(docId)
        let valueToWrite: T = value
        
        do {
        
            try ref.setData(from: valueToWrite)
            return valueToWrite
        } catch let error {
            print("Error: \(#function) in collection: \(collection), \(error)")
            throw error
        }
    }

}

// MARK: - DELETE
extension FirebaseService {
    func delete<T: FirebaseIdentifiable>(_ value: T, in collection: String) async -> Result<Void, Error> {
        let ref = database.collection(collection).document(value.id)
        do {
            // 1.
            try await ref.delete()
            return .success(())
        } catch let error {
            print("Error: \(#function) in \(collection) for id: \(value.id), \(error)")
            return .failure(error)
        }
    }
}
