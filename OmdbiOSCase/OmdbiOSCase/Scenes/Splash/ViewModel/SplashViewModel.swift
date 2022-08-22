//
//  SplashViewModel.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit

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

    weak var delegate: SplashViewModelDelegate?
    var navigationController: UINavigationController?
    
    func fetchTextFromRemoteConfig() -> String? {
        let remoteConfig = RemoteConfigManager()
        
        if let keyValue = remoteConfig.fetchStringValue(with: "splash_key") {
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

//MARK: Route
extension SplashViewModel {
    
    func pushMovieListWithTimer(navigationController: UINavigationController) {
        self.navigationController = navigationController
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(pushMovieList), userInfo: nil, repeats: false)
    }

    @objc private func pushMovieList() {
        guard let navController = self.navigationController else { return }
        let splashRouter = SplashRouter(navigationController: navController)
        splashRouter.routeToMovieList()
    }
}
