//
//  File.swift
//  NetworkLayer
//
//  Created by Mehmet fatih DOĞAN on 16.04.2022.
//

import Foundation

public typealias HTTPHeaders = [String:String]

protocol HTTPEndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}



