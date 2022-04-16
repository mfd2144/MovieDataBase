//
//  MovieApi.swift
//  NetworkLayer
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation

public enum MovieApi {
    case upcoming(page:Int)
    case newMovies(page:Int)
}

extension MovieApi: HTTPEndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .upcoming:
            return "upcoming"
        case .newMovies:
            return "now_playing"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page),.upcoming(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
            
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
