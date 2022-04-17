//
//  MovieResults.swift
//  NetworkLayer
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation


public struct MovieResults {
    public let page: Int
    public let numberOfResults: Int
    public let numberOfPages: Int
    public let movies: [Movie]
}

extension MovieResults: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)
        
    }
}

