//
//  ComicResponse.swift
//  MovieBox
//
//  Created by Akif Demirezen on 15.03.2022.
//  Copyright © 2022 akifdemirezen. All rights reserved.
//

import Foundation
import UIKit

public struct ComicResponse : Decodable, Equatable {
    public var code : Int?
    public var status : String?
    public var copyright : String?
    public var attributionText : String?
    public var attributionHTML : String?
    public var etag : String?
    public var data : DataComics?
    public var comicList : [ComicModel]?
    
    public init(comicList : [ComicModel]) {
        self.comicList = comicList
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
        data = try values.decodeIfPresent(DataComics.self, forKey: .data)
    }
    
}
public struct DataComics : Decodable, Equatable {
    var offset : Int?
    var limit : Int?
    var total : Int?
    var count : Int?
    var results : [ComicModel]?

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
        results = try values.decodeIfPresent([ComicModel].self, forKey: .results)
    }

}


public struct CharactersComics : Decodable, Equatable {
    var available : Int?
    var collectionURI : String?
    var items : [ItemsComics]?
    var returned : Int?

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
        items = try values.decodeIfPresent([ItemsComics].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }

}
public struct Creators : Decodable, Equatable {
    var available : Int?
    var collectionURI : String?
    var items : [ItemsComics]?
    var returned : Int?

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
        items = try values.decodeIfPresent([ItemsComics].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }

}
public struct DatesComics : Decodable, Equatable {
    var type : String?
    var date : String?

    public enum CodingKeys: String, CodingKey {

        case type = "type"
        case date = "date"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        date = try values.decodeIfPresent(String.self, forKey: .date)
    }

}
public struct EventsComics : Decodable, Equatable {
    var available : Int?
    var collectionURI : String?
    var items : [ItemsComics]?
    var returned : Int?

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
        items = try values.decodeIfPresent([ItemsComics].self, forKey: .items)
        returned = try values.decodeIfPresent(Int.self, forKey: .returned)
    }

}
public struct ImagesComics : Decodable, Equatable {
    var path : String?
    var extensionString : String?

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
public struct ItemsComics : Decodable, Equatable {
    var resourceURI : String?
    var name : String?
    var type : String?

    public enum CodingKeys: String, CodingKey {

        case resourceURI = "resourceURI"
        case name = "name"
        case type = "type"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}
public struct PricesComics : Decodable, Equatable {
    var type : String?
    var price : Double?

    public enum CodingKeys: String, CodingKey {

        case type = "type"
        case price = "price"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
    }

}
public struct ComicModel : Decodable, Equatable {
    var id : Int?
    var digitalId : Int?
    var title : String?
    var issueNumber : Int?
    var variantDescription : String?
    var description : String?
    var modified : String?
    var isbn : String?
    var upc : String?
    var diamondCode : String?
    var ean : String?
    var issn : String?
    var format : String?
    var pageCount : Int?
    var textObjects : [TextObjectsComics]?
    var resourceURI : String?
    var urls : [UrlsComics]?
    var series : SeriesComics?
    var variants : [VariantsComics]?
    var collections : [String]?
    var collectedIssues : [String]?
    var dates : [DatesComics]?
    var prices : [PricesComics]?
    var thumbnail : ThumbnailComics?
    var images : [ImagesComics]?
    var creators : CreatorsComics?
    var characters : CharactersComics?
    var stories : StoriesComics?
    var events : EventsComics?

    public enum CodingKeys: String, CodingKey {

        case id = "id"
        case digitalId = "digitalId"
        case title = "title"
        case issueNumber = "issupublic enumber"
        case variantDescription = "variantDescription"
        case description = "description"
        case modified = "modified"
        case isbn = "isbn"
        case upc = "upc"
        case diamondCode = "diamondCode"
        case ean = "ean"
        case issn = "issn"
        case format = "format"
        case pageCount = "pageCount"
        case textObjects = "textObjects"
        case resourceURI = "resourceURI"
        case urls = "urls"
        case series = "series"
        case variants = "variants"
        case collections = "collections"
        case collectedIssues = "collectedIssues"
        case dates = "dates"
        case prices = "prices"
        case thumbnail = "thumbnail"
        case images = "images"
        case creators = "creators"
        case characters = "characters"
        case stories = "stories"
        case events = "events"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        digitalId = try values.decodeIfPresent(Int.self, forKey: .digitalId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        issueNumber = try values.decodeIfPresent(Int.self, forKey: .issueNumber)
        variantDescription = try values.decodeIfPresent(String.self, forKey: .variantDescription)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        isbn = try values.decodeIfPresent(String.self, forKey: .isbn)
        upc = try values.decodeIfPresent(String.self, forKey: .upc)
        diamondCode = try values.decodeIfPresent(String.self, forKey: .diamondCode)
        ean = try values.decodeIfPresent(String.self, forKey: .ean)
        issn = try values.decodeIfPresent(String.self, forKey: .issn)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
        textObjects = try values.decodeIfPresent([TextObjectsComics].self, forKey: .textObjects)
        resourceURI = try values.decodeIfPresent(String.self, forKey: .resourceURI)
        urls = try values.decodeIfPresent([UrlsComics].self, forKey: .urls)
        series = try values.decodeIfPresent(SeriesComics.self, forKey: .series)
        variants = try values.decodeIfPresent([VariantsComics].self, forKey: .variants)
        collections = try values.decodeIfPresent([String].self, forKey: .collections)
        collectedIssues = try values.decodeIfPresent([String].self, forKey: .collectedIssues)
        dates = try values.decodeIfPresent([DatesComics].self, forKey: .dates)
        prices = try values.decodeIfPresent([PricesComics].self, forKey: .prices)
        thumbnail = try values.decodeIfPresent(ThumbnailComics.self, forKey: .thumbnail)
        images = try values.decodeIfPresent([ImagesComics].self, forKey: .images)
        creators = try values.decodeIfPresent(CreatorsComics.self, forKey: .creators)
        characters = try values.decodeIfPresent(CharactersComics.self, forKey: .characters)
        stories = try values.decodeIfPresent(StoriesComics.self, forKey: .stories)
        events = try values.decodeIfPresent(EventsComics.self, forKey: .events)
    }

}
public struct SeriesComics : Decodable, Equatable {
    var resourceURI : String?
    var name : String?

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
public struct StoriesComics : Decodable, Equatable {
    var available : Int?
    var collectionURI : String?
    var items : [Items]?
    var returned : Int?

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
public struct ThumbnailComics : Decodable, Equatable {
    var path : String?
    var extensionString : String?

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
public struct UrlsComics : Decodable, Equatable {
    var type : String?
    var url : String?

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
public struct VariantsComics : Decodable, Equatable {
    var resourceURI : String?
    var name : String?

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
public struct CreatorsComics : Decodable, Equatable {
    let available : Int?
    let collectionURI : String?
    let items : [Items]?
    let returned : Int?

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

public struct TextObjectsComics : Decodable, Equatable {
    let type : String?
    let language : String?
    let text : String?

    public enum CodingKeys: String, CodingKey {

        case type = "type"
        case language = "language"
        case text = "text"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        language = try values.decodeIfPresent(String.self, forKey: .language)
        text = try values.decodeIfPresent(String.self, forKey: .text)
    }
}
