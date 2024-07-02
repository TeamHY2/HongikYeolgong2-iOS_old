//
//  HomeView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var coordinator: SceneCoordinator    
    
    var body: some View {
        NavigationStack(path: $coordinator.paths) {
            VStack {
                Text("Home View 🏠")
                Button(action: {
                    coordinator.push(.menu)
                }, label: {
                    Text("Go to menu")
                })
            }
            .navigationDestination(for: SceneType.self) { scene in
                coordinator.buildScreen(scene: scene)
            }
        }
    }
}

#Preview {
    HomeView()
}
