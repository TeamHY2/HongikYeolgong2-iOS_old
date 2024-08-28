//
//  RemoteConfig.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/28/24.
//

import SwiftUI
import FirebaseRemoteConfig

final class RemoteConfigManager: ObservableObject {
    static let shared = RemoteConfigManager()
    
    let remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
        
    init() {
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func getStudyTime() async -> Int? {
        do {
            try await remoteConfig.fetch()
            try await remoteConfig.activate()
            return remoteConfig["studyTime"].numberValue.intValue
        } catch {
            print("RemoteConfig Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getWiseSaying() async -> [WiseSaying]? {
        do {
            try await remoteConfig.fetch()
            try await remoteConfig.activate()
            let data = remoteConfig["wiseSaying"].dataValue
            
            
            let result = try JSONDecoder().decode([WiseSaying].self, from: data)
            return result
        } catch {
            print("RemoteConfig Error: \(error.localizedDescription)")
            return nil
        }
    }
}
