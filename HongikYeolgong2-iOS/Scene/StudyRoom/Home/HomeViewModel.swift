//
//  HomeViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import SwiftUI

final class HomeViewModel: ViewModelType {
    @Published var isSuccess = false
    @Published var wiseSaying: [WiseSaying] = []
    
    enum Action {
        case getWiseSaying
    }
    
    func send(action: Action) {
        switch action {
        case .getWiseSaying:
            Task {
                await getWiseSaying()
            }
        }
    }
    
    func getWiseSaying() async {
        guard let wiseSaying = await RemoteConfigManager.shared.getWiseSaying() else {
            return
        }
        self.wiseSaying = wiseSaying
        DispatchQueue.main.async {
            self.isSuccess = true
        }
    }
}
