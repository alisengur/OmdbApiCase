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

extension SplashViewController: SplashViewModelDelegate {
    
    func handleViewModelOutput(output: SplashViewModelOutput) {
        switch output {
        case .showText(let text):
            //TODO: show text
            print(text)
        case .showAlert:
            //TODO: show alert
            print("error")
        }
    }
    
}
