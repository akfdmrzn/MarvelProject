//
//  UITableViewCellExtensionsTests.swift
//  UtilitiesTests
//
//  Created by Akif Demirezen on 23.11.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import XCTest
@testable import Utilities

class UITableViewCellExtensionsTests: XCTestCase {
    
    func test_tableviewCell_Identifier() {
        XCTAssertEqual(MockTableViewCell.identifier, "MockTableViewCell")
    }
}

private class MockTableViewCell: UITableViewCell { }
