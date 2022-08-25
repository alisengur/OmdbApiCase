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
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private let movieTableView: MovieTableView = MovieTableView()
    
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
        initializeTableView()
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: Initialize UI Components
private extension MovieListViewController {
    
    func initializeSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
    }
    
    func initializeTableView() {
        tableView.registerCell(MovieCell.self)

        tableView.delegate = movieTableView
        tableView.dataSource = movieTableView
        movieTableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
    }
    
    func updateTableView(movies: [MovieModel]) {
        self.movieTableView.update(movies: movies)
        self.tableView.reloadData()
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    
    func handleViewModelOutput(output: MovieListViewModelOutput) {
        switch output {
        case .reloadTable(let movieResult):
            self.updateTableView(movies: movieResult)
        case .showWarningAlert(let message):
            self.updateTableView(movies: [])
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

extension MovieListViewController: MovieTableViewDelegate {
    
    func handleTableViewOutput(output: MovieTableViewOutput) {
        
        switch output {
        case .onSelected(let movie):
            // route to movie detail
            guard let navigationController = self.navigationController else { return }
            self.viewModel.pushMovieDetail(navigationController: navigationController,
                                           movie: movie)
        }
    }
}
