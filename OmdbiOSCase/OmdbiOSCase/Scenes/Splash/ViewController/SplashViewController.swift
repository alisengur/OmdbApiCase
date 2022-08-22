//
//  SplashViewController.swift
//  OmdbiOSCase
//
//  Created by Ali Şengür on 21.08.2022.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var labelTitle: UILabel!
    
    // MARK: Inject
    private let viewModel: SplashViewModel
    
    // MARK: Initializer
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.checkInternetConnection()
    }
}

//MARK: Alert
extension SplashViewController {
    
    private func showAlert() {
        let alert = UIAlertController(title: "Hata",
                                      message: "İnternet bağlantınızı kontrol edin.",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SplashViewController: SplashViewModelDelegate {
    
    func handleViewModelOutput(output: SplashViewModelOutput) {
        switch output {
        case .showText(let text):
            labelTitle.text = text
            // route to movie list screen
            guard let navController = self.navigationController else { return }
            self.viewModel.pushMovieListWithTimer(navigationController: navController)
        case .showAlert:
            showAlert()
        }
    }
}
