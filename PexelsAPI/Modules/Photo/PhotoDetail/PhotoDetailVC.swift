//
//  PhotoDetailVC.swift
//  PexelsAPI
//
//  Created by Vitaliy on 10.02.2021.
//

import UIKit

final class PhotoDetailVC: UIViewController {
    private let mainView = PhotoDetailView()
    private let photo: PhotoInfo
    var presenter: PhotoDetailOutput!
    
    init(photo: PhotoInfo) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupView() {
        view = mainView
        title = photo.photographer
        setupBackButton()
        
        guard let viewModel = PhotoDetailViewModel(photo: photo) else {
            fatalError()
        }
        mainView.setup(with: viewModel)
        
        mainView.imageTapped = { [weak self] in
            self?.presentPhotoZoomVC()
        }
    }
    
    private func presentPhotoZoomVC() {
        guard let image = photo.image else {
            assert(false)
            return
        }
        let creator = PhotoZoomCreator(image: image,
                                       imageHeight: photo.scaledSize.height)
        let vc = creator.createModule()
        navigationController?.pushViewController(vc, animated: false)
    }
}


extension PhotoDetailVC: PhotoDetailViewInput {
    func showOriginalPhotoSize(size: String) {
        mainView.addOriginalPhotoSize(size)
    }
}
