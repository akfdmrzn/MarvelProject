//
//  CharacterListViewTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 23.11.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MovieBox

class CharacterListViewTests: XCTestCase {

    func test_movieList_load()  {
        let service = MockCharactersListService()
        let viewModel = CharacterListViewModel(apiClient: service)
        let viewController = CharacterListViewController()
        viewController.viewModel = viewModel
        
        _ = viewController.view
    
        XCTAssertNotNil(viewController.collectionView)
    }
}
