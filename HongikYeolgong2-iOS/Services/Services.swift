//
//  Services.swift
//  HongikYeolgong2-iOS
//
//  Created by 변정훈 on 7/11/24.
//

import Foundation

protocol ServiceType {
    var authService: AuthenticationServiceType { get set }
}

class Services: ServiceType {
    var authService: AuthenticationServiceType
    init()   {
        self.authService = AuthenticationService()
    }
    
}

class StubService: ServiceType {
    var authService: AuthenticationServiceType = StubAuthenticationService()
}
