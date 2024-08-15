//
//  FirestoreIdentifiable.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/13/24.
//

import Foundation

protocol FirestoreIdentifiable: Hashable, Codable, Identifiable {
    var id: String { get set }
}

typealias Dictionary = [String: Any]

extension Encodable {
    
    func asDictionary() -> Dictionary {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary else {
            return [:]
        }
        return dictionary
    }
}
