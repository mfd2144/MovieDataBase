//
//  Movie.swift
//  NetworkLayer
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation

public struct Movie {
    public let id: Int
    public let posterPath: String
    public let backdrop: String?
    public let title: String
    public let releaseDate: String
    public let rating: Double
    public let overview: String
}

extension Movie: Decodable {
   public enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
    
    public init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        id = try movieContainer.decode(Int.self, forKey: .id)
        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
        backdrop =  try? movieContainer.decode(String.self, forKey: .backdrop) 
        title = try movieContainer.decode(String.self, forKey: .title)
        releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
        rating = try movieContainer.decode(Double.self, forKey: .rating)
        overview = try movieContainer.decode(String.self, forKey: .overview)
    }
}
