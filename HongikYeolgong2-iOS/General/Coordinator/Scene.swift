//
//  Scene.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import Foundation

enum AuthSceneType: Hashable {
    case login
}

extension AuthSceneType {
    static func == (lhs: AuthSceneType, rhs: AuthSceneType) -> Bool {
       return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .login:
            hasher.combine("login")
        }
    }
}

enum SceneType: Hashable {
    case loginOnboarding
    case home
    case menu
}

extension SceneType {
    static func == (lhs: SceneType, rhs: SceneType) -> Bool {
       return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine("home")
        case .loginOnboarding:
            hasher.combine("login")
        case .menu:
            hasher.combine("menu")
        }
    }
}

enum FullScreenType: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case test
}
enum SheetType: String, Identifiable {
    var id: String {
        self.rawValue
    }
    
    case test
}
