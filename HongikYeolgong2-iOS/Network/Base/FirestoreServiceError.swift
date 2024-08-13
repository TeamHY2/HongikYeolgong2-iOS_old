//
//  FirestoreServiceError.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/13/24.
//

import Foundation

public enum FirestoreServiceError: Error {
    case invalidPath
    case invalidType
    case collectionNotFound
    case documentNotFound
    case unknownError
    case parseError
    case invalidRequest
    case operationNotSupported
    case invalidQuery
    case operationNotAllowed
}
