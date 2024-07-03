//
//  MenuView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var loginManager = LoginManager.shared
    @EnvironmentObject private var coordinator: SceneCoordinator
    @ObservedObject var viewModel: MenuViewModel
    
    var body: some View {
        VStack {
            Text("Menu View ⚙️")
            Text("\(viewModel.title)")
            
            Button(action: {
                coordinator.popToRoot()
                loginManager.logout()
            }, label: {
                Text("Logout test")
            })
        }
    }
}

#Preview {
    MenuView(viewModel: MenuViewModel())
}
