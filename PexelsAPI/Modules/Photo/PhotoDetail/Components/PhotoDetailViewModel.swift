//
//  PhotoDetailViewModel.swift
//  PexelsAPI
//
//  Created by Vitaliy on 15.04.2021.
//

import UIKit

struct PhotoDetailViewModel {
    let image: UIImage
    let imageHeight: CGFloat
    let currentResolution: String
    let originalResolution: String
    let currentFileSize: String
    var originalFileSize: String?
    
    init?(photo: PhotoInfo) {
        guard let image = photo.image else { return nil }
        self.image = image
        self.imageHeight = photo.scaledSize.height
        self.currentResolution = "\(image.pixelsWidth) x \(image.pixelsHeight)"
        self.originalResolution = "\(photo.width) x \(photo.height)"
        self.currentFileSize = "(\(image.fileSize))"
        self.originalFileSize = "(...)"
    }
}
