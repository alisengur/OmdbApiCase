//
//  MovieListRouter.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit

final class MovieListRouter {
 
    internal let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeToMovieDetail(with movie: MovieModel) {
        // route to movie list screen
        let movieDetailsVC = MovieDetailsBuilder.generate(with: movie)
        self.navigationController.pushViewController(movieDetailsVC, animated: true)
    }

}
