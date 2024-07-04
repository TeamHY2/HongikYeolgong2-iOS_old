//
//  MenuView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var coordinator: SceneCoordinator
    
    var body: some View {
        VStack {
           Text("Menu View")
        }
        .customNavigation(right: {
            Button(action: {
                coordinator.dismissFullScreenCover()
            }, label: {
                Image(systemName: "xmark")
            })
        })
    }
}

#Preview {
    MenuView()
}
