//
//  MovieCell.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 23.08.2022.
//

import Foundation
import ProgressHUD
import Kingfisher

class MovieCell: BaseTableViewCell {
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieGenreLabel: UILabel!
    @IBOutlet private weak var movieDirectorLabel: UILabel!
    
    func configureCell(movieModel: MovieModel) {
        fetchMoviePoster(url: movieModel.poster)

        movieTitleLabel.text = movieModel.title
        movieYearLabel.text = movieModel.year
    }
    
    func fetchMoviePoster(url:String) {
        if let url = URL(string: url) {
            //showLoaderAnimation()
            movieImageView.kf.setImage(with: url) { result in
                //self.hideLoaderAnimation()
                
                switch result {
                case .success(let imageResult):
                    self.movieImageView.image = imageResult.image
                case .failure(let error):
                    self.movieImageView.image = UIImage(named: "no_image_placeholder")
                    print(error.localizedDescription)
                }
            }
        }
    }
}
