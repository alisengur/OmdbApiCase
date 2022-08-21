//
//  MovieListBuilder.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit

final class MovieListBuilder {
    
    static func generate() -> SplashViewController {
        // TODO: Injections
        let viewModel = SplashViewModel()
        return SplashViewController(viewModel: viewModel)
    }
}
