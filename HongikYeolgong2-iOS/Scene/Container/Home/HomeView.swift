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
            VStack(spacing: 0) {
                Quote()                
            }
            .customNavigation(left: {
                CustomText(font: .suite, title: "홍익열공이", textColor: .customGray100, textWeight: .semibold, textSize: 18)
            }, right: {
                Button(action: {
                    coordinator.push(.menu)
                }, label: {
                    Image(.icHamburger)
                })
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
