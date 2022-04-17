//
//  MovieServices.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import Foundation

enum MovieType{
    case upComing(Int)
    case nowPlaying(Int)
}

enum MovieResult<Value> {
    case success(Value)
    case failure(String)
}

typealias MovieDataBaseCompletion = (MovieResult<[MoviePresentation]>)->Void

protocol MovieDataBaseProtocol{
    mutating func setUp()
    func fetchMovies(type:MovieType,completion:@escaping(MovieDataBaseCompletion))
}
