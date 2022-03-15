//
//  APIError.swift
//  MovieBoxAPI
//
//  Created by Akif Demirezen on 27.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case invalidURL = "The URL is invalid"
    case invalidData = "The data is invalid"
    case invalidResponse = "The response is invalid"
}
