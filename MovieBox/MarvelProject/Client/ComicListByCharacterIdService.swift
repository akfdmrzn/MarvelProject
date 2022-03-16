//
//  ComicListByCharacterIdService.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//
import Foundation

public protocol ComicListByCharacterIdServiceProtocol {
    func fetchComicList(limit : Int,characterId : Int,dateRange : String,orderBy : String,completion: @escaping (Result<ComicResponse>) -> Void)
}

public class ComicListByCharacterIdService: ComicListByCharacterIdServiceProtocol {
    
    public var apiEngine: APIEngineProtocol
    
    public init(apiEngine: APIEngineProtocol) {
        self.apiEngine = apiEngine
    }
    
    public func fetchComicList(limit : Int,characterId : Int,dateRange : String,orderBy : String,completion: @escaping (Result<ComicResponse>) -> Void) {
        guard let url = URL(string: APIEndPoints.comics.buildUrl()+"/\(characterId)/comics"+"\(AppConstants.API.md5PublicAndPrivateKey)"+"&dateRange=\(dateRange)&orderBy=\(orderBy)&limit=\(limit)") else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        apiEngine.get(url: url) { (data, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.invalidData))
                return
            }
            
            let decoder = Decoders.plainDateDecoder
            if let response = try? decoder.decode(ComicResponse.self, from: data) {
                completion(.success(response))
            } else {
                completion(.failure(APIError.invalidResponse))
            }
        }
    }
}
