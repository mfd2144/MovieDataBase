//
//  Date.swift
//  MobilliumMovies
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import Foundation

extension Date{
    static func yearString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    static func dateStringWithDots(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date)
    }
}
