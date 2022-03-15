//
//  MovieDetailCoordinator.swift
//  MovieBox
//
//  Created by Ömer Faruk Öztürk on 29.10.2019.
//  Copyright © 2019 omerfarukozturk. All rights reserved.
//

import UIKit
import MovieBoxAPI

protocol MovieDetailCoordinatorDelegate: class {
    func requestDismissal()
}

class MovieDetailCoordinator: CoordinatorProtocol {
    weak var coordinatorDelegate: MovieDetailCoordinatorDelegate?
    
    let navigationController: UINavigationController
    let movie: CharacterModel
    
    init(navigationController: UINavigationController, movie: CharacterModel) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    func start() {
        let viewModel = MovieDetailViewModel(movie: movie)
        viewModel.coordinatorDelegate = self
        let detailViewController = MovieDetailViewController(viewModel: viewModel)
        navigationController.present(detailViewController, animated: true, completion: nil)
    }
}

extension MovieDetailCoordinator: MovieDetailCoordinatorViewModelDelegate {
    
    func dismiss() {
        coordinatorDelegate?.requestDismissal()
    }
}
