//
//  PhotoDetailCreator.swift
//  PexelsAPI
//
//  Created by Vitaliy on 24.02.2021.
//

import UIKit
import Swinject

struct PhotoDetailCreator: ModuleCreator, SelfDescription {
    private let resolver: Resolver
    private let photo: PhotoInfo
    
    init(photo: PhotoInfo) {
        self.resolver = DependencyContainer.shared.resolver
        self.photo = photo
    }
    
    func createModule() -> UIViewController {
        guard let service = resolver.resolve(ImageService.self) else {
            fatalError("Cannot create \(Self.selfName)")
        }
        
        let presenter = PhotoDetailPresenter(service: service, photo: photo)
        let vc = PhotoDetailVC(photo: photo)
        vc.presenter = presenter
        presenter.view = vc
        
        vc.hidesBottomBarWhenPushed = true
        return vc
    }
}
