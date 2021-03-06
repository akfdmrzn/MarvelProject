//
//  Constants.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//

import UIKit

struct AppConstants {
    
    struct ContentCollection {
        static let PosterImageRatio: CGFloat = 3.0/2.0
        static let HorizontalSpaceBetweenItems: CGFloat = 8
        static let VerticleSpaceBetweenItems: CGFloat = 8
    }
    
    struct ParameterValues {
        static let CharactersLimit : Int = 10
        static let ScrollIncreaseLimit : Int = 30
        static let ScrollTotalLimit : Int = 100
    }
    
    struct API {
        static let baseURL = "http://gateway.marvel.com"
        static let md5PublicAndPrivateKey = "?ts=1&apikey=1f60e169eda9fc8114337914564ac214&hash=2c36299d1a589ce4ed0b9278fda0b92c"
    }
    
    struct ImagesExtend {
        static let portRaitUncanny = "/portrait_uncanny.jpg"
    }
}

enum APIEndPoints {
    case characters
    case comics
    
    func endPoint() -> String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .comics:
            return "/v1/public/characters"
        }
    }
    
    func buildUrl() -> String {
        return AppConstants.API.baseURL + endPoint()
    }
}

