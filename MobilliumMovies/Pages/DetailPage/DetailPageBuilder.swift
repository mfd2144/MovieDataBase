//
//  DetailPageBuilder.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//
import UIKit

final class DetailPageBuilder{
    static func make(movie:MoviePresentation)->UIViewController{
        let view = DetailPageViewController()
        view.movie = movie
        return view
    }
}
