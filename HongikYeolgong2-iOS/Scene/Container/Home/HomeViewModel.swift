//
//  HomeViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/11/24.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var isRoomReserved = false
    @Published var useageStartTime = Date()
    @Published var showingAlert = false
    @Published var showingAlert2 = false
    @Published var showingDialog = false
    
    func startRoomUsage() {
        isRoomReserved = true
    }
    
    func cancleRoomUsage() {
        isRoomReserved = false
    }
}
