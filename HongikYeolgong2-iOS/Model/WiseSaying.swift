//
//  WiseSaying.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import Foundation

struct Response: Decodable {
    let result: [WiseSaying]
}

struct WiseSaying: Decodable {
    let quote: String
    let author: String
}
