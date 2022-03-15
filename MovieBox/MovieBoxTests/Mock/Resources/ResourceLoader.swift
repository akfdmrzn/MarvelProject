//
//  ResourceLoader.swift
//  MovieBoxTests
//
//  Created by Akif Demirezen on 28.10.2019.
//  Copyright © 2019 akifdemirezen. All rights reserved.
//

import Foundation
@testable import MovieBox


class ResourceLoader {
    
    enum MovieResource: String {
        case movie1
        case movie2
        case movie3
    }
    
    static func loadMovie(resource: MovieResource) throws -> Movie {
        let bundle = Bundle.init(for: ResourceLoader.self)
        let url = try bundle.url(forResource: resource.rawValue, withExtension: "json").unwrap()
        let data = try Data(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let movie = try decoder.decode(Movie.self, from: data)
        return movie
    }
    
    static func loadMovieItem(resource: MovieResource) throws -> MovieItem {
        let movie = try loadMovie(resource: resource)
        return MovieItem(movie)
    }
}
