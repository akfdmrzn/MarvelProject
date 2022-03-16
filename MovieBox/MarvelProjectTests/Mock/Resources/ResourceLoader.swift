//
//  ResourceLoader.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation
@testable import MarvelProject

class ResourceLoader {
    
    enum MarvelResource: String {
        case character1
    }
    
    static func loadCharacter(resource: MovieResource) throws -> CharacterModel {
        let bundle = Bundle.init(for: ResourceLoader.self)
        let url = try bundle.url(forResource: resource.rawValue, withExtension: "json").unwrap()
        let data = try Data(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let movie = try decoder.decode(Movie.self, from: data)
        return movie
    }
    
    static func loadCharacterItem(resource: MarvelResource) throws -> CharacterResponse {
        let character = try loadCharacter(resource: resource)
        return CharacterResponse.init(charactersList: [character])
    }
}
