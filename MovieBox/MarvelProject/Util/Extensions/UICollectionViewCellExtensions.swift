//
//  UICollectionViewCellExtensions.swift
//  Utilities
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    public class var identifier: String {
        return String(describing: self)
    }
}
