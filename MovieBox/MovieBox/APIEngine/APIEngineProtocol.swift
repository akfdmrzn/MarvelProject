//
//  APIEngineProtocol.swift
//  MovieBoxAPI
//
//  Created by Akif Demirezen on 27.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

public protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    public func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return (dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask) as URLSessionDataTaskProtocol
    }
}

public protocol APIEngineProtocol {
    typealias CompletionHandler = ( _ data: Data?, _ error: Error?) -> Void
    
    var urlSession: URLSessionProtocol { get set }
    
    func get(url: URL, completion: @escaping CompletionHandler)
}

