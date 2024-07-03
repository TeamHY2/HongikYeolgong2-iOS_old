//
//  Scene.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import Foundation

enum SceneType: Hashable {
    case loginOnboarding
    case home
    case menu
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
