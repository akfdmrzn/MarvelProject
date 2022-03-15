//
//  CharacterDetailViewModelTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MovieBox

class CharacterDetailViewModelTests: XCTestCase {
    
    func test_viewModel_renderMovie() throws {
        // Given:
        let movie = try ResourceLoader.loadMovieItem(resource: .movie1)
        let sut = try makeSUT()
        
        // Then:
        XCTAssertEqual(sut.getCharacterDetail(), movie)
    }
    
    // MARK: Helpers
    func makeSUT() throws -> CharacterDetailViewModel {
        let movie = try ResourceLoader.loadMovieItem(resource: .movie1)
        let viewModel = CharacterDetailViewModel(movie: movie)
        return viewModel
    }
}
