//
//  MovieDataBaseManager.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import Foundation
import NetworkLayer

struct NetworkLayerManager:MovieDataBaseProtocol{
    var manager:NetworkManager!
    mutating func setUp() {
         manager = NetworkManager()
     }
    func fetchMovies(type: MovieType, completion: @escaping (MovieDataBaseCompletion)) {
        var movieKind:MovieApi!
        switch type {
        case .upComing(let int):
            movieKind = .upcoming(page: int)
        case .nowPlaying(let int):
            movieKind = .newMovies(page: int)
        }
        manager.getNewMovies(kind:movieKind) { movie, error in
            if let error = error {
                completion(.failure(error))
            }else{
                guard let movie = movie else {
                    completion(.failure("There isn't any showned movie"))
                    return
                }
                let movies = movie.map {MoviePresentation.init(movieObject: $0)}
                completion(.success(movies))
            }
        }
    }
    
    
}
