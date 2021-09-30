//
//  Photo.swift
//  PexelsAPI
//
//  Created by Vitaliy on 01.02.2021.
//

import Foundation
import UIKit

struct PhotoInfo: Codable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let photographerId: Int
    let avgColor: String
    let sizes: PhotoSizes
    let liked: Bool
    
    // MARK: - additional local properties
    /// path for download image
    var thumbPathRemote: String {
        return sizes.large
    }
    /// downloaded image from thumbPathRemote
    var image: UIImage?
    /// image size after scaled to device width. This value setted by default and will be calculated later.
    var scaledSize = CGSize(width: UIScreen.main.bounds.width,
                            height: 400)

    enum CodingKeys: String, CodingKey {
        case id, width, height, url, photographer
        case photographerUrl
        case photographerId
        case avgColor
        case sizes = "src"
        case liked
    }
}


struct PhotoSizes: Codable {
    let original: String
    let large2x: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
}
