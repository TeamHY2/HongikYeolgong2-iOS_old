//
//  User.swift
//  HongikYeolgong2-iOS
//
//  Created by 변정훈 on 7/12/24.
//

import Foundation

struct User: FirestoreIdentifiable, Decodable {
    var id: String
    let email: String
    var nickname: String?
    var department: String?
}
