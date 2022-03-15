//
//  Results.swift
//  MovieBoxAPI
//
//  Created by Akif Demirezen on 27.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

