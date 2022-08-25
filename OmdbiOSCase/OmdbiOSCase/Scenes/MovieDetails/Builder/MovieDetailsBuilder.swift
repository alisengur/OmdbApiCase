//
//  MovieDetailsBuilder.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 23.08.2022.
//

import Foundation
import UIKit

final class MovieDetailsBuilder {
    
    static func generate(with movie: MovieModel) -> MovieDetailsViewController {
        let service: OmdbApiServiceProtocol = OmdbApiService()
        let viewModel = MovieDetailsViewModel(movie: movie, service: service)
        return MovieDetailsViewController(viewModel: viewModel)
    }
}
