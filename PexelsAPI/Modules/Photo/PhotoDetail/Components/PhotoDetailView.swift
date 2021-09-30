//
//  PhotoDetailView.swift
//  PexelsAPI
//
//  Created by Vitaliy on 25.02.2021.
//

import UIKit

final class PhotoDetailView: XibView {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var currentResolutionLabel: UILabel!
    @IBOutlet var currentFileSizeLabel: UILabel!
    @IBOutlet var originalResolutionLabel: UILabel!
    @IBOutlet var originalFileSizeLabel: UILabel!
    
    var imageTapped: (() -> Void)?
    
    override func didLoadView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
        imageTapped?()
    }
    
    func setup(with model: PhotoDetailViewModel) {
        imageView.image = model.image
        imageHeightConstraint.constant = model.imageHeight
        currentResolutionLabel.text = model.currentResolution
        currentFileSizeLabel.text = model.currentFileSize
        originalResolutionLabel.text = model.originalResolution
        originalFileSizeLabel.text = model.originalFileSize
    }
    
    func addOriginalPhotoSize(_ size: String) {
        originalFileSizeLabel.text = size
    }
}
