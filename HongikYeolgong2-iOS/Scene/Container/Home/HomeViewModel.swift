//
//  HomeViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/11/24.
//

import Foundation
import Combine

final class HomeViewModel: ViewModelType {
    // State
    @Published var isBooked = false
    @Published var startTime = Date()
    @Published var endTime: Date!
    @Published var showingAlert = false
    @Published var showingAlert2 = false
    @Published var showingDialog = false
    @Published var timeRemaining = 0
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Inject var calendarRepository: CalendarRepositoryType
    
    // Input
    enum Action {
        case startUsing
        case showDialog
        case showAlert
        case showAlert2
        case useCompleted
    }
    
    // Binding
    func send(action: Action) {
        switch action {
        case .startUsing:
            isBooked = true
            endTime = startTime + TimeInterval(3600 * 6)
            timeRemaining = Int(endTime.timeIntervalSince(startTime))
            
            timer.sink { [weak self] _ in
                guard let self = self else { return }
                timeRemaining -= 1
            }
            .store(in: &cancellables)
        case .showDialog:
            showingDialog = true
        case .showAlert:
            showingAlert = true
        case .showAlert2:
            showingAlert2 = true
        case .useCompleted:
            isBooked = false
            cancellables.removeAll()
        }
    }
}
