//
//  CharactersListService.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//

import Foundation

public protocol CharactersListServiceProtocol {
    func fetchCharactersList(limit : Int,offSet : Int,completion: @escaping (Result<CharacterResponse>) -> Void)
}

public class CharactersListService: CharactersListServiceProtocol {
    
    public var apiEngine: APIEngineProtocol
    
    public init(apiEngine: APIEngineProtocol) {
        self.apiEngine = apiEngine
    }
    
    public func fetchCharactersList(limit : Int,offSet : Int,completion: @escaping (Result<CharacterResponse>) -> Void) {
        guard let url = URL(string: APIEndPoints.characters.buildUrl()+"\(AppConstants.API.md5PublicAndPrivateKey)"+"&limit=\(limit)"+"&offset=\(offSet)") else {
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
            if let response = try? decoder.decode(CharacterResponse.self, from: data) {
                completion(.success(response))
            } else {
                completion(.failure(APIError.invalidResponse))
            }
        }
    }
}
