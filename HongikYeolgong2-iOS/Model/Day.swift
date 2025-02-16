//
//  Day.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import Foundation

struct Day: Identifiable {
    var id = UUID().uuidString
    let dayOfNumber: String
    var usageRecord: [StudyRoomUsage] = []
    
    var todayUsageCount: Int {
        return usageRecord.count
    }
}

struct StudyRoomUsage: FirestoreIdentifiable {
    var id: String = UUID().uuidString
    let date: Date
    let duration: Double
}



