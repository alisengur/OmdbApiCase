//
//  MovieListViewModel.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import ProgressHUD

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
    case reloadTable(movieResult: [MovieModel])
    case showWarningAlert(message: String)
}

class MovieListViewModel: MovieListViewModelProtocol {

    var delegate: MovieListViewModelDelegate?
    private var service: OmdbApiServiceProtocol
    private var searchTimer: Timer?
    
    init(service: OmdbApiServiceProtocol) {
        self.service = service
    }
    
    func searchMovie(with name: String) {
        ProgressHUD.show()
        
        // eğer bir search requesti için sonlanmamış bir timer var ise, yeni request atmadan önce bu timer'ı kaldırıyoruz(çakışmaları engellemek için)
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        
        searchTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(searchForKeyword(_:)), userInfo: name, repeats: false)
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
        let searchText = timer.userInfo as! String
        
        service.searchMovie(with: searchText) { [weak self] movieResult in
            if let movieResult = movieResult.search {
                ProgressHUD.dismiss()
                self?.delegate?.handleViewModelOutput(output: .reloadTable(movieResult: movieResult))
            }
        } onFailure: { error in
            guard let error = error else { return }
            self.delegate?.handleViewModelOutput(output: .showWarningAlert(message: error))
        }
    }
    
    func getPermissionForNotification() {
        //TODO: get permission from user for notification
    }
    
}
