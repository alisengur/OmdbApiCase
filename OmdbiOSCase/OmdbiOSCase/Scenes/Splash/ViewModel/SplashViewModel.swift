//
//  SplashViewModel.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation

protocol SplashViewModelDelegate: AnyObject {
    func handleViewModelOutput(output: SplashViewModelOutput)
}

protocol SplashViewModelProtocol {
    var delegate: SplashViewModelDelegate? { get set }
    
    func fetchTextFromRemoteConfig() -> String?
    func checkInternetConnection()
}

enum SplashViewModelOutput {
    case showText(text: String)
    case showAlert
}

class SplashViewModel: SplashViewModelProtocol {

    var delegate: SplashViewModelDelegate?

    func fetchTextFromRemoteConfig() -> String? {
        let remoteConfig = RemoteConfigManager()
        if let keyValue = remoteConfig.fetchStringValue(with: "splash_screen_key") {
            return keyValue
        } else {
            return nil
        }
    }
    
    
    func checkInternetConnection() {
        if Reachability.isConnectedToNetwork() {
            // TODO: fetch text from Firebase Remote Config
            if let text = fetchTextFromRemoteConfig() {
                delegate?.handleViewModelOutput(output: .showText(text: text))
            }
        } else {
            delegate?.handleViewModelOutput(output: .showAlert)
        }
    }
}
