//
//  UIImage.swift
//  PexelsAPI
//
//  Created by Vitaliy on 27.01.2021.
//

import UIKit

extension UIImage {
    var pixelsWidth: Int {
        return Int(size.width * scale)
    }
    
    var pixelsHeight: Int {
        return Int(size.height * scale)
    }
    
    var fileSize: String {
        guard let bytesCount = pngData()?.count else {
            return "?"
        }
        return BytesHelper.getFileSize(bytes: UInt(bytesCount))
    }
    
    var scaleFactorToScreenWidth: CGFloat {
        return UIScreen.main.bounds.width / size.width
    }
    
    var scaledSizeToScreenWidth: CGSize {
        return CGSize(width: UIScreen.main.bounds.width,
                      height: size.height * scaleFactorToScreenWidth)
    }
    
    func scalePreservingAspectRatioTo(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(width: size.width * scaleFactor,
                                     height: size.height * scaleFactor)

        return renderTo(size: scaledImageSize)
    }
    
    func convertToScreenWidth() -> UIImage {
        return renderTo(size: scaledSizeToScreenWidth)
    }
    
    // Draw and return the resized UIImage
    private func renderTo(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return scaledImage
    }
}
