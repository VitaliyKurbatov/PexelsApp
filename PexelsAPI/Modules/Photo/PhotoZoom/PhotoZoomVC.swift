//
//  PhotoZoomVC.swift
//  PexelsAPI
//
//  Created by Vitaliy on 13.04.2021.
//

import UIKit

final class PhotoZoomVC: UIViewController {
    private let mainView = PhotoZoomView()
    private let image: UIImage
    private let imageHeight: CGFloat
    
    init(image: UIImage, imageHeight: CGFloat) {
        self.image = image
        self.imageHeight = imageHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupView() {
        view = mainView
        
        mainView.imageHeightConstraint.constant = imageHeight
        mainView.imageView.image = image
        
        mainView.closeTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
    }
}
