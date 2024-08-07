//
//  UserRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import Combine

protocol UserRepositoryType {
    func createUser(uid: String) -> AnyPublisher<User, Never>
    func fetchUser(uid: String)
}

final class UserRepositoryImpl: UserRepositoryType {
    func createUser(uid: String) -> AnyPublisher<User, Never> {
        return Empty().eraseToAnyPublisher()
    }
    
    func fetchUser(uid: String) {
        
    }
}
