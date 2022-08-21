//
//  RemoteConfigManager.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import FirebaseRemoteConfig

final class RemoteConfigManager {
    
    private let settings: RemoteConfigSettings
    private let remoteConfig: RemoteConfig
    
    init() {
        settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        
        remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = settings
    }
    
    func fetchStringValue(with key: String) -> String? {
        let value = remoteConfig.configValue(forKey: key).stringValue
        return value
    }
}
