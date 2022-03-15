//
//  AppCoordinatorTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 27.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MovieBox

class AppCoordinatorTest: XCTestCase {
    
    func test_appCoordinator_createRootViewController() {
        let coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        coordinator.start()
        XCTAssertNotNil(coordinator.rootViewController)
    }
    
    func test_appCoordinator_routeToDetail() throws {
        let coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        coordinator.start()
        
        coordinator.showDetails(of: try ResourceLoader.loadMovieItem(resource: .movie1))
        XCTAssertTrue(coordinator.rootViewController.presentedViewController is CharacterDetailViewController)
    }
}
