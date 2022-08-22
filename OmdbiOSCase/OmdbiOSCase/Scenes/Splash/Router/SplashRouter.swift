//
//  SplashRouter.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit

final class SplashRouter {
 
    internal let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToMovieList() {
        let movieListVC = MovieListBuilder.generate()
        self.navigationController.pushViewController(movieListVC, animated: true)
    }

}
