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
                Button(action: {
                    coordinator.present(fullScreen: .menu)
                }, label: {
                    Text("Go to menu ⚙️")
                })
            }
            .customNavigation(left: {
                Text("홍익열공이")
            }, right: {
                Image(systemName: "line.3.horizontal")
            })
            .navigationDestination(for: SceneType.self) { scene in
                coordinator.buildScreen(scene: scene)
            }
            .sheet(item: $coordinator.sheet) { sheet in
                coordinator.buildScreen(sheet: sheet)
            }
            .fullScreenCover(item: $coordinator.fullScreen) { fullScreen in
                coordinator.buildScreen(fullScreen: fullScreen)
            }
        }
    }
}

#Preview {
    HomeView()
}
