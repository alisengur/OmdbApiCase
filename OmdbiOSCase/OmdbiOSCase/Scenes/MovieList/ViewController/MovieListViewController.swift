//
//  MovieListViewController.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: Outlets
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    
    func handleViewModelOutput(output: MovieListViewModelOutput) {
        //...
    }
}
