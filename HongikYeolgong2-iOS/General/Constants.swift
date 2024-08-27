//
//  Constants.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/30/24.
//

import Foundation
import Firebase

enum Constants {
    struct StudyRoomService {
        static let additionalTime: TimeInterval = .hours(6)
        static let firstNotificationTime: TimeInterval = .minutes(30)
        static let secondNotificationTime: TimeInterval = .minutes(10)
    }
    
    struct Url {
        static let roomStatus = "http://203.249.65.81/RoomStatus.aspx"
        static let notice = "https://url.kr/elogg8"
        static let Qna = "https://forms.gle/J1CtFrySdwTYcixk9"
    }
}
