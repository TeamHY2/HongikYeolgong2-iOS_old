//
//  SceneCoordinator.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

final class SceneCoordinator: ObservableObject {
    @Published var paths: [SceneType] = []
    @Published var authPath: [AuthSceneType] = []
    @Published var sheet: SheetType?
    @Published var fullScreen: FullScreenType?
    
    func push(_ scene: SceneType) {
        paths.append(scene)
    }
    
    func pop() {
        _ = paths.popLast()
    }
    
    func popToRoot() {
        paths.removeAll()
    }
    
    func present(fullScreen: FullScreenType) {
        self.fullScreen = fullScreen
    }
    
    func present(sheet: SheetType) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreen = nil
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
    
    @ViewBuilder
    func buildScreen(sheet: SheetType) -> some View {
        switch sheet {
        case .test:
            Text("Sheet test!")
        }
    }
    
    @ViewBuilder
    func buildScreen(fullScreen: FullScreenType) -> some View {
        switch fullScreen {
        case .test:
            Text("fullScreen test!")
        }
    }
}
