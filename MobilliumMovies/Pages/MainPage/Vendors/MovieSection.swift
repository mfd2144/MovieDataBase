//
//  MovieSection.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import Foundation

enum MovieSection:Int,CaseIterable{
    case nowPlaying
    case upComing

    var cellIdentifier:String{
        switch self {
        case .nowPlaying:
            return "NowPlayingMoviesCell"
        case .upComing:
            return "UpComingMoviesCell"
       
        }
    }
}
