//
//  MovieListBuilder.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit

final class MovieListBuilder {
    
    static func generate() -> MovieListViewController {
        // TODO: Injections
        let viewModel = MovieListViewModel()
        return MovieListViewController(viewModel: viewModel)
    }
}
