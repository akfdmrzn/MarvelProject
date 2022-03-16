//
//  OptionalExtensions.swift
//  Utilities
//
//  Created by Akif Demirezen on 27.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

public extension Optional {
    
    struct FoundNilError: Error { }
    
    func unwrap() throws -> Wrapped {
        switch self {
        case .some(let wrapped):
            return wrapped
        case .none:
            throw FoundNilError()
        }
    }
}
