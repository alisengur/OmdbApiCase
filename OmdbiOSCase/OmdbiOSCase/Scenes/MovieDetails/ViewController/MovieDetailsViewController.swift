//
//  MovieDetailsViewController.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 23.08.2022.
//

import Foundation
import UIKit
import ProgressHUD
import Kingfisher

class MovieDetailsViewController: UIViewController {
 
    //MARK: Outlets
    @IBOutlet private weak var moviePosterImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieDescripitonLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieDurationlabel: UILabel!
    @IBOutlet private weak var movieGenresLabel: UILabel!
    @IBOutlet private weak var movieDirectorLabel: UILabel!
    @IBOutlet private weak var movieActorsLabel: UILabel!
    @IBOutlet private weak var movieMetascoreLabel: UILabel!
    @IBOutlet private weak var movieIMDBRatingLabel: UILabel!
    
    // MARK: Inject
    private let viewModel: MovieDetailsViewModel
    
    // MARK: Initializer
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.initializeView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func fillDataToView(movieDetail: MovieDetailModel) {
        if let poster = movieDetail.poster,
            let posterURL = URL(string: poster) {
            moviePosterImageView.kf.setImage(with: posterURL)
        }
        
        movieTitleLabel.text = movieDetail.title
        movieDescripitonLabel.text = movieDetail.plot
        movieYearLabel.text = "Year: \(movieDetail.year ?? "")"
        movieDurationlabel.text = "Duration: \(movieDetail.runtime ?? "")"
        movieGenresLabel.text = "Genres: \(movieDetail.genre ?? "")"
        movieDirectorLabel.text = "Director: \(movieDetail.director ?? "")"
        movieActorsLabel.text = "Actors: \(movieDetail.actors ?? "")"
        movieIMDBRatingLabel.text = "IMDB Rating : \(movieDetail.imdbRating ?? "")"
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    
    func handleViewModelOutput(output: MovieDetailsViewModelOutput) {
        switch output {
        case .fillDataToView(let movieDetailModel):
            fillDataToView(movieDetail: movieDetailModel)
        case .showWarningAlert(let message):
            ProgressHUD.showError(message, image: nil, interaction: false)
        }
    }
}
