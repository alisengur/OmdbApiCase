//
//  MovieTableView.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 23.08.2022.
//

import Foundation
import UIKit

protocol MovieTableViewProtocol {
    func update(movies: [MovieModel])
}

protocol MovieTableViewDelegate: AnyObject {
    func handleTableViewOutput(output: MovieTableViewOutput)
}

enum MovieTableViewOutput {
    case onSelected(movie: MovieModel)
}


final class MovieTableView: NSObject {
    
    private lazy var movies: [MovieModel] = []
    
    weak var delegate: MovieTableViewDelegate?
}

extension MovieTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.generateReusableCell(MovieCell.self, indexPath: indexPath)
        cell.configureCell(movieModel: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.handleTableViewOutput(output: .onSelected(movie: movies[indexPath.row]))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension MovieTableView: MovieTableViewProtocol {
    
    func update(movies: [MovieModel]) {
        self.movies = movies
    }
}
