//
//  MovieListViewTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 23.11.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MovieBox

class MovieListViewTests: XCTestCase {

    func test_movieList_load()  {
        let service = MockCharactersListService()
        let viewModel = MovieListViewModel(apiClient: service)
        let viewController = MovieListViewController()
        viewController.viewModel = viewModel
        
        _ = viewController.view
    
        XCTAssertNotNil(viewController.collectionView)
    }
}
