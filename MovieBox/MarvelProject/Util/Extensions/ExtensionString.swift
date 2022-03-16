//
//  ExtensionString.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//

import UIKit

extension String {
    var toCleanDateString : String{
        
        let seperatedDay : [String] = self.components(separatedBy: "T")
        if let date = seperatedDay.first{
            return date
        }
        return ""
    }

}
