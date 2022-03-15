//
//  CharacterResponse.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//

import Foundation
import UIKit

public struct CharacterResponse : Decodable, Equatable {
    public var code : Int?
    public var status : String?
    public var copyright : String?
    public var attributionText : String?
    public var attributionHTML : String?
    public var etag : String?
    public var data : DataCharacter?
    public var charactersList : [CharacterModel]?
    
    public init(charactersList : [CharacterModel]) {
        self.charactersList = charactersList
    }
    
    public enum CodingKeys: String, CodingKey {

        case code = "code"
        case status = "status"
        case copyright = "copyright"
        case attributionText = "attributionText"
        case attributionHTML = "attributionHTML"
        case etag = "etag"
        case data = "data"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        attributionText = try values.decodeIfPresent(String.self, forKey: .attributionText)
        attributionHTML = try values.decodeIfPresent(String.self, forKey: .attributionHTML)
        etag = try values.decodeIfPresent(String.self, forKey: .etag)
        data = try values.decodeIfPresent(DataCharacter.self, forKey: .data)
    }

}
public struct CharacterModel : Decodable, Equatable {
    public var id : Int?
    public var name : String?
    public var description : String?
    public var modified : String?
    public var thumbnail : Thumbnail?
    public var resourceURI : String?
    public var comics : Comics?
    public var series : Series?
    public var stories : Stories?
    public var events : Events?
    public var urls : [Urls]?
    public var isFavourited : Bool?

    public enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case description = "description"
        case modified = "modified"
        case thumbnail = "thumbnail"
        case resourceURI = "resourceURI"
        case comics = "comics"
        case series = "series"
        case stories = "stories"
        case events = "events"
        case urls = "urls"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        comics = try values.decodeIfPresent(Comics.self, forKey: .comics)
        series = try values.decodeIfPresent(Series.self, forKey: .series)
        stories = try values.decodeIfPresent(Stories.self, forKey: .stories)
        events = try values.decodeIfPresent(Events.self, forKey: .events)
        urls = try values.decodeIfPresent([Urls].self, forKey: .urls)
    }

}

public struct Comics : Decodable, Equatable {
    public var available : Int?
    public var collectionURI : String?
    public var items : [Items]?
    public var returned : Int?

    public enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }

}

public struct DataCharacter : Decodable, Equatable {
    public var offset : Int?
    public var limit : Int?
    public var total : Int?
    public var count : Int?
    public var results : [CharacterModel]?
    
    public enum CodingKeys: String, CodingKey {

        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case results = "results"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        results = try values.decodeIfPresent([CharacterModel].self, forKey: .results)
    }

}

public struct Events : Decodable, Equatable {
    public var available : Int?
    public var collectionURI : String?
    public var items : [Items]?
    public var returned : Int?

    public enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }

}
public struct Items : Decodable, Equatable {
    public var resourceURI : String?
    public var name : String?

    public enum CodingKeys: String, CodingKey {

        case resourceURI = "resourceURI"
        case name = "name"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}
public struct Series : Decodable, Equatable {
    public var available : Int?
    public var collectionURI : String?
    public var items : [Items]?
    public var returned : Int?

    public enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }

}
public struct Stories : Decodable, Equatable {
    public var available : Int?
    public var collectionURI : String?
    public var items : [Items]?
    public var returned : Int?

    public enum CodingKeys: String, CodingKey {

        case available = "available"
        case collectionURI = "collectionURI"
        case items = "items"
        case returned = "returned"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        collectionURI = try values.decodeIfPresent(String.self, forKey: .collectionURI)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }

}
public struct Thumbnail : Decodable, Equatable {
    public var path : String?
    public var extensionString : String?

    public enum CodingKeys: String, CodingKey {

        case path = "path"
        case extensionString = "extension"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        extensionString = try values.decodeIfPresent(String.self, forKey: .extensionString)
    }

}
public struct Urls : Decodable, Equatable {
    public var type : String?
    public var url : String?

    public enum CodingKeys: String, CodingKey {

        case type = "type"
        case url = "url"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
