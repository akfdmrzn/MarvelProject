//
//  CharacterDetailViewTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MovieBox

class CharacterDetailViewTest: XCTestCase {
    
    func test_detail_controller_deinited() throws {
        let exp = expectation(description: "deinit")
        
        let movie1 = try ResourceLoader.loadMovieItem(resource: .movie1)
        let viewModel = CharacterDetailViewModel(movie: movie1)
        var sut: MockDetailView? = MockDetailView(viewModel: viewModel)
        
        sut?.deinitCalled = {
            exp.fulfill()
        }
        
        DispatchQueue.global(qos: .background).async {
            sut = nil
        }
        
        waitForExpectations(timeout: 4.0)
    }
}

private class MockDetailView: CharacterDetailViewController {
    var deinitCalled: (() -> Void)?
    deinit { deinitCalled?() }
}
