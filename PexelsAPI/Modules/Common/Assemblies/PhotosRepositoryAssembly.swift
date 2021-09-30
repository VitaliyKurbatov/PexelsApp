//
//  PhotosRepositoryAssembly.swift
//  PexelsAPI
//
//  Created by Vitaliy on 09.02.2021.
//

import Swinject

class PhotosRepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PhotosRepository.self) { _ in
            return PhotosRepository()
        }
    }
}
