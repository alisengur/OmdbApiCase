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
        let service: OmdbApiServiceProtocol = OmdbApiService()
        let viewModel = MovieListViewModel(service: service)
        return MovieListViewController(viewModel: viewModel)
    }
}
