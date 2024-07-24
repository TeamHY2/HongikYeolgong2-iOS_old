//
//  TimerViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/24/24.
//

import Foundation
import Combine

final class TimerViewModel: ViewModelType {
    // State
    @Published var isStart = false
    @Published var startTime = Date()
    @Published var endTime: Date!
    @Published var timeRemaining = 0
    @Published var totalTime = 0
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    private var cancellables = Set<AnyCancellable>()
    
    // Input
    enum Action {
        case startButtonTap
        case completeButtonTap
        case addTimeButtonTap
    }
    
    // Binding
    func send(action: Action) {
        switch action {
        case .startButtonTap:
            isStart = true
            endTime = startTime + TimeInterval(3600 * 6)
            timeRemaining = Int(endTime.timeIntervalSince(startTime))
            
            timer.sink { [weak self] _ in
                guard let self = self else { return }
                timeRemaining -= 1
            }
            .store(in: &cancellables)
        case .completeButtonTap:
            cancellables.removeAll()
            isStart = false
            totalTime = Int(endTime.timeIntervalSince(startTime)) - timeRemaining         
        case .addTimeButtonTap:
            totalTime = Int(endTime.timeIntervalSince(startTime)) - timeRemaining
            endTime = endTime + TimeInterval(3600 * 6)            
            timeRemaining = Int(endTime.timeIntervalSince(startTime)) - totalTime
        }
    }
}

