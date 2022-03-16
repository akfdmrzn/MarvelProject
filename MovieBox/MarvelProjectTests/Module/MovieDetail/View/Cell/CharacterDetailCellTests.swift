//
//  CharacterDetailCellTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MovieBox

class CharacterDetailCellTests: XCTestCase {
    
    func test_setup_rendersCorrectData() throws {
        let sut = makeSUT()
        let character = try ResourceLoader.loadMovieItem(resource: .movie1)
        sut.setup(with: movie)
        
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertEqual(sut.titleLabel.text, movie.title)
        
    }
    
    // MARK: Helpers
    
    func makeSUT() -> CharacterDetailCell {
        let nib = UINib(nibName: CharacterDetailCell.identifier, bundle: nil)
        let cell = nib.instantiate(withOwner: nil, options: [:]).first as! CharacterDetailCell
        return cell
    }
}
