//
//  MockCharactersListService.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation

final class MockCharactersListService: CharactersListServiceProtocol {
    
    var characterList: [CharacterModel]?

    func fetchCharactersList(limit: Int, offSet: Int, completion: @escaping (Result<CharacterResponse>) -> Void) {
//        completion(.success(CharacterResponse(from: characterList)))
    }
}
