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
                    coordinator.push(.menu(MenuViewModel()))
                }, label: {
                    Text("Go to menu")
                })
                
                Button(action: {
                    coordinator.present(sheet: .test)
                }) {
                    Text("Sheet")
                }
                
                Button(action: {
                    coordinator.present(fullScreen: .test)
                }) {
                    Text("FullScreen")
                }
            }            
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
