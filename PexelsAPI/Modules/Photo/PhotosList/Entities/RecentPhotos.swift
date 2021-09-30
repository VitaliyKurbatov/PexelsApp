//
//  RecentPhotos.swift
//  PexelsAPI
//
//  Created by Vitaliy on 01.02.2021.
//

import Foundation

struct RecentPhotos: Codable {
    let page: Int
    let perPage: Int
    let photosInfo: [PhotoInfo]
    let nextPage: String
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage
        case photosInfo = "photos"
        case nextPage
    }
}
