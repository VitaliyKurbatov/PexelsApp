//
//  PhotoZoomCreator.swift
//  PexelsAPI
//
//  Created by Vitaliy on 13.04.2021.
//

import UIKit

struct PhotoZoomCreator: ModuleCreator {
    private let image: UIImage
    private let imageHeight: CGFloat
    
    init(image: UIImage, imageHeight: CGFloat) {
        self.image = image
        self.imageHeight = imageHeight
    }
    
    func createModule() -> UIViewController {
        return PhotoZoomVC(image: image,
                           imageHeight: imageHeight)
    }
}
