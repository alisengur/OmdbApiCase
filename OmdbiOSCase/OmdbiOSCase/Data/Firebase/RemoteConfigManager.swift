//
//  RemoteConfigManager.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import FirebaseRemoteConfig

class RemoteConfigManager {
    
    init() {
        setRemoteConfigDefaults()
    }
    
    func setRemoteConfigDefaults() {
        let appDefaults: [String: Any?] = [
          "splash_key": "Text"
        ]
        RemoteConfig.remoteConfig().setDefaults(appDefaults as? [String: NSObject])
    }
    
    func activateDebugMode() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        RemoteConfig.remoteConfig().configSettings = settings
    }
    
    
    func fetchStringValue(with key: String) -> String? {
        activateDebugMode()
        
        RemoteConfig.remoteConfig().fetch { [weak self] _, error in
          if let error = error {
              print(error)
              //TODO: progress
            return
          }

          RemoteConfig.remoteConfig().activate { _, _ in
            print("Retrieved values from the cloud!")
          }
        }
        
        let value = RemoteConfig.remoteConfig().configValue(forKey: key).stringValue ?? "undefined"
        return value
    }
}
