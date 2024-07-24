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
    var studyRecord: [StudyRecord]?
}

struct StudyRecord: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let totalTime: Int
}



