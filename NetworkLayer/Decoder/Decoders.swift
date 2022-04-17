//
//  Decoders.swift
//  NetworkLayer
//
//  Created by Mehmet fatih DOĞAN on 17.04.2022.
//

import Foundation

public enum PlainDateDecoder{
    public static let decoder:JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
