//
//  MovieDetailsViewModel.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 23.08.2022.
//

import Foundation

protocol MovieDetailsViewModelDelegate: AnyObject {
    func handleViewModelOutput(output: MovieDetailsViewModelOutput)
}

protocol MovieDetailsViewModelProtocol {
    var delegate: MovieDetailsViewModelDelegate? { get set }
    
}

enum MovieDetailsViewModelOutput {
    case fillDataToView(movieDetailModel: MovieDetailModel)
    case showWarningAlert(message: String)
}

class MovieDetailsViewModel {
    
    private let service: OmdbApiServiceProtocol
    private let movie: MovieModel?
    weak var delegate: MovieDetailsViewModelDelegate?
    
    init(movie: MovieModel, service: OmdbApiServiceProtocol) {
        self.movie = movie
        self.service = service
    }
    
    private var movieId: String? {
        return movie?.imdbID
    }
    
    func initializeView() {
        getMovieDetailsFromService(with: movieId ?? "")
    }
    
    func getMovieDetailsFromService(with movieId: String) {
        service.getMovieDetail(with: movieId) { [weak self] movieDetailResult in
            self?.delegate?.handleViewModelOutput(output: .fillDataToView(movieDetailModel: movieDetailResult))
        } onFailure: { error in
            guard let error = error else { return }
            self.delegate?.handleViewModelOutput(output: .showWarningAlert(message: error))
        }


    }
}
