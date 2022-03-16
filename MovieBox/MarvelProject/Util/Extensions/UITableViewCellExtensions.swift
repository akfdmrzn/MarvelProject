//
//  UITableViewCellExtensions.swift
//  Utilities
//
//  Created by Akif Demirezen on 29.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    public class var identifier: String {
        return String(describing: self)
    }
}
