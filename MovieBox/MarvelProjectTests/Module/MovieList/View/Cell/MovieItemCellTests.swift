//
//  CharacterItemCellTests.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 23.11.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import MovieBox
@testable import Utilities

class CharacterItemCellTests: XCTestCase {

    func test_cell_rendersCorrectData() throws {
        let cell = makeSUT()
        let movieItem = try ResourceLoader.loadMovieItem(resource: .movie1)
        cell.setup(with: movieItem)
        
        XCTAssertEqual(movieItem.title, cell.titleLabel.text)
        XCTAssertNotNil(cell.posterImage)
        XCTAssertNotNil(cell.titleBackgroundView)
    }
    
    private func makeSUT() -> CharacterItemCell {
        let nib = UINib(nibName: CharacterItemCell.identifier, bundle: nil)
        let cell = nib.instantiate(withOwner: nil, options: [:]).first as! CharacterItemCell
        return cell
    }
}
