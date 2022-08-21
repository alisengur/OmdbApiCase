//
//  MovieListViewModel.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation

protocol MovieListViewModelDelegate: AnyObject {
    func handleViewModelOutput(output: MovieListViewModelOutput)
}

protocol MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate? { get set }
    
    func searchMovie(with name: String)
    func getPermissionForNotification()
}

enum MovieListViewModelOutput {
    case setLoading(Bool)
    case reloadTable
}

class MovieListViewModel: MovieListViewModelProtocol {

    var delegate: MovieListViewModelDelegate?

    func searchMovie(with name: String) {
        //TODO: search movie from service
        delegate?.handleViewModelOutput(output: .reloadTable)
    }
    
    func getPermissionForNotification() {
        //TODO: get permission from user for notification
    }
    
}
