//
//  PhotosApi.swift
//  PexelsAPI
//
//  Created by Vitaliy on 01.02.2021.
//

import Foundation
import Moya

enum PhotosApi {
    case recentPhotos(page: UInt)
}


extension PhotosApi: NetworkTarget {
    var path: String {
        switch self {
        case .recentPhotos:
            return "curated"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recentPhotos:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .recentPhotos(let page):
            return .requestParameters(parameters: ["page": page,
                                                   "per_page": 10],
                                      encoding: URLEncoding.default)
        }
    }
}
