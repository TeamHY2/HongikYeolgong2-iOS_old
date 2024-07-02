//
//  SceneCoordinator.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

final class SceneCoordinator: ObservableObject {
    @Published var paths: [SceneType] = []
    
    func push(_ scene: SceneType) {
        paths.append(scene)
    }
    
    func pop() {
        _ = paths.popLast()
    }
    
    func popToRoot() {
        paths.removeAll()
    }
    
    @ViewBuilder
    func buildScreen(scene: SceneType) -> some View {
        switch scene {
        case .home:
            HomeView()
        case .loginOnboarding:
            LoginView()
        case .menu:
            MenuView()        
        }
    }
}
