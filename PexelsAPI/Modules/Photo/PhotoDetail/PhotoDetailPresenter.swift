//
//  PhotoDetailPresenter.swift
//  PexelsAPI
//
//  Created by Vitaliy on 16.04.2021.
//

import Foundation

final class PhotoDetailPresenter: PhotoDetailOutput {
    weak var view: PhotoDetailViewInput?
    private let service: ImageService
    private let photo: PhotoInfo
    
    func viewDidLoad() {
        service.getRemoteFileSize(path: photo.sizes.original) { [weak self] fileSize in
            guard let self = self, let fileSize = fileSize else { return }
            self.view?.showOriginalPhotoSize(size: "(\(fileSize))")
        }
    }
    
    init(service: ImageService, photo: PhotoInfo) {
        self.service = service
        self.photo = photo
    }
}
