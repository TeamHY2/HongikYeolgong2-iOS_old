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
        static let additionalTime = TimeInterval(60)
        static let firstNotificationTime = TimeInterval(30)
        static let secondNotificationTime = TimeInterval(10)
        
        static let starRatingCount00 = TimeInterval(10)
        static let starRatingCount01 = TimeInterval(20)
        static let starRatingCount02 = TimeInterval(30)
    }
    
    struct Url {
        static let roomStatus = "http://203.249.65.81/RoomStatus.aspx"
    }
}
