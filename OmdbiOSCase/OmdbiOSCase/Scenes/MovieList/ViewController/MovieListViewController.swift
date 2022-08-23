//
//  MovieListViewController.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit
import ProgressHUD

class MovieListViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var searchBar: UISearchBar!
    
    // MARK: Inject
    private let viewModel: MovieListViewModel
    
    // MARK: Initializer
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSearchBar()
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

private extension MovieListViewController {
    
    func initializeSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    
    func handleViewModelOutput(output: MovieListViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            print(isLoading)
        case .reloadTable(let movieResult):
            print(movieResult)
        case .showWarningAlert(let message):
            ProgressHUD.showError(message, image: nil, interaction: false)
        }
    }
}

// MARK: Search Bar Delegate -
extension MovieListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchMovie(with: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
    }

}
