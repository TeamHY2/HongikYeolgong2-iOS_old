//
//  DIContainer.swift
//  HongikYeolgong2-iOS
//
//  Created by 변정훈 on 7/11/24.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
