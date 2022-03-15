//
//  MovieDetailViewModel.swift
//  MovieBox
//
//  Created by Ömer Faruk Öztürk on 29.10.2019.
//  Copyright © 2019 omerfarukozturk. All rights reserved.
//

import Foundation
import MovieBoxAPI

// - MARK: Coordinator Delegate
protocol MovieDetailCoordinatorViewModelDelegate: class {
    func dismiss()
}

protocol MovieDetailViewModelProtocol {
    var coordinatorDelegate: MovieDetailCoordinatorViewModelDelegate? { get set }
    func getMovieDetail() -> CharacterModel
    func dismiss()
}

class MovieDetailViewModel: MovieDetailViewModelProtocol {
    var coordinatorDelegate: MovieDetailCoordinatorViewModelDelegate?
    
    private var movie: CharacterModel!
    
    init(movie: CharacterModel) {
        self.movie = movie
    }

    func getMovieDetail() -> CharacterModel {
        return movie
    }
    
    func dismiss() {
        coordinatorDelegate?.dismiss()
    }
}


