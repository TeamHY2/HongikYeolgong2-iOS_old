//
//  HomeViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/11/24.
//

import Foundation

final class HomeViewModel: ViewModelType {
    @Published var isBooked = false
    @Published var useageStartTime = Date()
    @Published var showingAlert = false
    @Published var showingAlert2 = false
    @Published var showingDialog = false
        
    @Inject var calendarRepository: CalendarRepositoryType
    
    
    enum Action {
        case startUsing
        case showDialog
        case showAlert
        case showAlert2
        case useCompleted
    }
    
    func send(action: Action) {
        switch action {
        case .startUsing:
            isBooked = true
        case .showDialog:
            showingDialog = true
        case .showAlert:
            showingAlert = true
        case .showAlert2:
            showingAlert2 = true
        case .useCompleted:
            break
        }
    }
}
