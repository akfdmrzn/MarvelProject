//
//  DateExtensions.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//
import Foundation

extension Date {
    var requestDateFormat : String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let dateStr = dateFormatter.string(from: self)
        let seperatedDay : [String] = dateStr.components(separatedBy: "T")
        if let date = seperatedDay.first{
            return date
        }
        return ""
    }

}
