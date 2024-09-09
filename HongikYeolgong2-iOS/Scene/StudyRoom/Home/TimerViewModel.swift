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
    @Published var remainingTime: TimeInterval = 123456
    @Published var totalTime = 0.0
    
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    private var checkTime: Date?
    private var subscription: AnyCancellable?
    
    var studyTime: TimeInterval = .init(hours: 6)
    
    // Input
    enum Action {
        case startButtonTap(defaultTime: TimeInterval, currentTime: Date)
        case completeButtonTap
        case addTimeButtonTap
        case enterBackground
        case enterFoureground        
    }
    
    // Binding
    func send(action: Action) {
        switch action {
        case .startButtonTap(let defaultTime, let currentTime):
            startStudy(defaultTime, currentTime)
        case .completeButtonTap:
            saveTime()
        case .addTimeButtonTap:
            addTime()
        case .enterBackground:
            timeCheck()
        case .enterFoureground:
            setTime()
        }
    }
    
    func startStudy(_ defaultTime: TimeInterval,_ currentTime: Date) {
        isStart = true
        self.studyTime = defaultTime
        
        let timeDiff = Int(Date().timeIntervalSince(currentTime) / 60)

        endTime = startTime + studyTime - TimeInterval(minutes: timeDiff)
        remainingTime = endTime.timeIntervalSince(startTime)
        
        // Notification에 추가
        LocalNotificationService.shared.addNotification(interval: TimeInterval(remainingTime))
        
        startTimer()
    }
    
    func startTimer() {
        subscription = timer.sink { [weak self] _ in
            guard let self = self else { return }
            remainingTime -= 1
        }
    }
    
    func saveTime() {
        subscription?.cancel()
        isStart = false
        totalTime = endTime.timeIntervalSince(startTime) - remainingTime
        LocalNotificationService.shared.removeNotification()
    }
    
    func addTime() {
        totalTime = endTime.timeIntervalSince(startTime) - remainingTime
        endTime = endTime + studyTime
        remainingTime = endTime.timeIntervalSince(startTime) - totalTime
        
        // Notification 제거하고 다시 등록
        LocalNotificationService.shared.removeNotification()
        LocalNotificationService.shared.addNotification(interval: TimeInterval(remainingTime))
    }
    
    
    func timeCheck() {
        // 타이머 중지
        subscription?.cancel()
        // 백그라운드에 진입한 시간 기록
        checkTime = Date()
    }
    
    func setTime() {
        guard let checkTime = checkTime else {
            return
        }
        
        let timeDifferent = Date().timeIntervalSince(checkTime)
        remainingTime -= timeDifferent
        startTimer()
    }
}

