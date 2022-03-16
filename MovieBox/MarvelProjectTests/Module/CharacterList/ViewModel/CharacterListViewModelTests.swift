//
//  CharacterListViewModelTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MarvelProject

class CharacterListViewModelTests: XCTestCase {
    
    private var view: CharactersView!
    private var viewModel: CharacterListViewModel!
    
    override func setUp() {
    }
    
    func test_viewModel_renders_title(){
        // When:
        viewModel.load()

        // Then:
        XCTAssertEqual(viewModel.getTitle(), "Characters")
    }
    
    func test_viewModel_load() throws {
        // When:
        viewModel.load()
        
        // Then:
        XCTAssertLessThan(view.outputs.count, 1)
    }
}

private class CharactersView: CharacterListViewModelDelegate {
    var outputs: [CharacterListViewModelOutput] = []
    
    func handleViewModelOutput(_ output: CharacterListViewModelOutput) {
        outputs.append(output)
    }
    
    func reset(){
        outputs.removeAll()
    }
}
