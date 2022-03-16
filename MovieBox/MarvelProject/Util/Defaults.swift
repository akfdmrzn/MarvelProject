//
//  Defaults.swift
//  MovieBox
//
//  Created by Akif Demirezen on 16.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//

import Foundation

public class Defaults{
    public enum DefaultsType {
        case Favourite
    }
    
    public init(){}
    
    
    // UserEncryptedData
    public func saveFavourite(data:[Int]){
        let preferences = UserDefaults.standard
        preferences.set( data , forKey:getIdentifier(type: .Favourite))
        preferences.synchronize()
    }
    
    public func getFavourite() -> [Int]! {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: getIdentifier(type: .Favourite)) == nil {
            return []
        }
        let data:[Int] = preferences.value(forKey: getIdentifier(type: .Favourite)) as! [Int]
        return data
    }
    
    
    private  func  getIdentifier(type:DefaultsType)->String {
        switch type {
        case .Favourite:
            return "Favourite"
            
        }
    }
}

