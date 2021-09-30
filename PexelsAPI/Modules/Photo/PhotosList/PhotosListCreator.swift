//
//  PhotosListCreator.swift
//  PexelsAPI
//
//  Created by Vitaliy on 10.02.2021.
//

import UIKit
import Swinject

struct PhotosListCreator: ModuleCreator, SelfDescription {
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func createModule() -> UIViewController {
        guard let repository = resolver.resolve(PhotosRepository.self),
              let service = resolver.resolve(ImageService.self) else {
            fatalError("Cannot create \(Self.selfName)")
        }
        let cellsManager = ImageCellsManager()
        let imageTableVC = ImageTableVC(cellsManager: cellsManager)
        
        let vc = PhotosListVC(imageTableVC: imageTableVC)
        let presenter = PhotosListPresenter(repository: repository, service: service)
        presenter.view = vc
        vc.presenter = presenter
        
        return vc
    }
}
