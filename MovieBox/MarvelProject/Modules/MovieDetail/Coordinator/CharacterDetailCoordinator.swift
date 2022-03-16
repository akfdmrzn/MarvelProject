//
//  CharacterDetailCoordinator.swift
//  MovieBox
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

protocol CharacterDetailCoordinatorDelegate : class {
    func requestDismissal()
}

class CharacterDetailCoordinator: CoordinatorProtocol {
    weak var coordinatorDelegate: CharacterDetailCoordinatorDelegate?
    
    let navigationController: UINavigationController
    let character: CharacterModel
    
    init(navigationController: UINavigationController, character: CharacterModel) {
        self.navigationController = navigationController
        self.character = character
    }
    
    func start() {
        let apiEngine = APIEngine()
        let apiClient = ComicListByCharacterIdService(apiEngine: apiEngine)
        let viewModel = CharacterDetailViewModel(character: character, apiClient: apiClient)
        viewModel.coordinatorDelegate = self
        let detailViewController = CharacterDetailViewController(viewModel: viewModel)
        navigationController.present(detailViewController, animated: true, completion: nil)
    }
}

extension CharacterDetailCoordinator: CharacterDetailCoordinatorViewModelDelegate {
    
    func dismiss() {
        coordinatorDelegate?.requestDismissal()
    }
}
