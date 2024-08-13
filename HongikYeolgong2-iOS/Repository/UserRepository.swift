//
//  UserRepository.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import Combine

protocol UserRepositoryType {
    func createUser(_ user: User) -> AnyPublisher<User, Never>
    func fetchUser(with uid: String) -> AnyPublisher<User, Error>
}

final class UserRepository: UserRepositoryType {
    
    func createUser(_ user: User) -> AnyPublisher<User, Never> {
        
        return Future<User, Never> { promise in
            Task {
                do {
                    try await FirestoreService.request(Endpoint.createUser(user))
                    promise(.success(user))
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func fetchUser(with uid: String) -> AnyPublisher<User, Error> {
        return Future<User, Error> { promise in
            Task {
                do {
                    let user: User = try await FirestoreService.request(Endpoint.fetchUser(uid: uid))
                    promise(.success(user))
                } catch let error {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
