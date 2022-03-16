//
//  AppCoordinator.swift
//  MovieBox
//
//  Created by Akif Demirezen on 27.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    let window: UIWindow?
    var rootViewController: UINavigationController!
    var apiEngine: APIEngine!
    let apiClient: CharactersListServiceProtocol!
    
    var childCoordinator: CoordinatorProtocol?
    
    init(window: UIWindow) {
        self.window = window
        self.apiEngine = APIEngine()
        self.apiClient = CharactersListService(apiEngine: apiEngine)
    }
    
    func start() {
        guard let window = window else { return }
               
        let viewModel = CharacterListViewModel(apiClient: apiClient)
        viewModel.coordinatorDelegate = self
        let viewController = CharacterListViewController()
        viewController.viewModel = viewModel

        rootViewController = UINavigationController(rootViewController: viewController)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: MovieListCoordinatorViewModelDelegate {
    
    func showDetails(of character: CharacterModel) {
        let detailCoordinator = CharacterDetailCoordinator(navigationController: rootViewController, character: character)
        detailCoordinator.coordinatorDelegate = self
        childCoordinator = detailCoordinator
        detailCoordinator.start()
    }
}

extension AppCoordinator: CharacterDetailCoordinatorDelegate {
    func requestDismissal() {
        rootViewController.dismiss(animated: true)
        childCoordinator = nil
    }
}
