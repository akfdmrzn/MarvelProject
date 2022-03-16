//
//  ArrayExtensions.swift
//  Utilities
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

extension Array {
    public struct IndexOutOfBoundsError: Error { }
    
    public func element(at index: Int) throws -> Element {
        guard index >= 0 && index < self.count else {
            throw IndexOutOfBoundsError()
        }
        return self[index]
    }
}
