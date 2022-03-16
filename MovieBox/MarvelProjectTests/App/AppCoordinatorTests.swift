//
//  AppCoordinatorTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MarvelProject

class AppCoordinatorTest: XCTestCase {
    
    func test_appCoordinator_createRootViewController() {
        let coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        coordinator.start()
        XCTAssertNotNil(coordinator.rootViewController)
    }
    
    func test_appCoordinator_routeToDetail() throws {
        let coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        coordinator.start()
        
        coordinator.showDetails(of: try ResourceLoader.loadCharacterItem(resource: .character1))
        XCTAssertTrue(coordinator.rootViewController.presentedViewController is CharacterDetailViewController)
    }
}
