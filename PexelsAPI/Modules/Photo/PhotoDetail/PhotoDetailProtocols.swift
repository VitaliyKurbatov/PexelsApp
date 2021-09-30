//
//  PhotoDetailProtocols.swift
//  PexelsAPI
//
//  Created by Vitaliy on 16.04.2021.
//


// MARK: - PhotoDetailPresenter
protocol PhotoDetailOutput: AnyObject {
    func viewDidLoad()
}


// MARK: - PhotoDetailView
protocol PhotoDetailViewInput: AnyObject {
    func showOriginalPhotoSize(size: String)
}
