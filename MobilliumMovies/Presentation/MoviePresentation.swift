//
//  MoviePresentation.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation
import NetworkLayer

struct MoviePresentation{
    let title:String
    let id:Int
    let imageUrl:String?
    let backDropUrl:String?
    let releaseDate:Date
    let rating:Double
    let overview:String
    
    init(movieObject:Movie){
        self.title = movieObject.title
        self.id = movieObject.id
        if let urlString = movieObject.posterPath{
            self.imageUrl = "https://image.tmdb.org/t/p/w500"+urlString
        }else{
            self.imageUrl = nil
        }
       
        if let urlString = movieObject.backdrop{
            self.backDropUrl = "https://image.tmdb.org/t/p/w500"+urlString
        }else{
            backDropUrl = nil
        }
        self.releaseDate = movieObject.releaseDate
        self.rating = movieObject.rating
        self.overview = movieObject.overview
    }
}
extension MoviePresentation:Hashable{
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs:MoviePresentation,rhs:MoviePresentation)->Bool{
        return lhs.id == rhs.id
    }
}
