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
    
    func fetchTextFromRemoteConfig()
    func checkInternetConnection()
}

enum SplashViewModelOutput {
    case showText(text: String)
    case showAlert
}

class SplashViewModel: SplashViewModelProtocol {

    var delegate: SplashViewModelDelegate?

    func fetchTextFromRemoteConfig() {
        // TODO: fetch text from Firebase Remote Config
    }
    
    
    func checkInternetConnection() {
        if Reachability.isConnectedToNetwork() {
            // TODO: fetch text from Firebase Remote Config
            delegate?.handleViewModelOutput(output: .showText(text: ""))
        } else {
            delegate?.handleViewModelOutput(output: .showAlert)
        }
    }
}
